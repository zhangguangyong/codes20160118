@echo off
setlocal enabledelayedexpansion

set "p1=%1"
set "p2=%2"

if /i "%p1%" EQU "-help" (
	goto showHelp
)

:: ++++++++++++++++++++++++++++++获取上级路径-开始++++++++++++++++++++++++++++++++ ::
set curdir=%cd%
cd.. >nul
set "parentdir=%cd%"
cd /d "%curdir%" >nul
:: ++++++++++++++++++++++++++++++获取上级路径-结束++++++++++++++++++++++++++++++++ ::


:: ++++++++++++++++++++++++++++++获取当前时间-开始++++++++++++++++++++++++++++++++ ::
:: 当前日期时间
set "curdatetime="
:: 拼接当前日期
for /f "usebackq tokens=1-3 delims=-/. " %%a in (`date /t`) do (
	set curdatetime=%%a%%b%%c
)
:: 拼接当前时间
for /f "tokens=1-4 delims=:-/. " %%a in ("%time%") do (
	set curdatetime=!curdatetime!%%a%%b%%c%%d
)
:: ++++++++++++++++++++++++++++++获取当前时间-结束++++++++++++++++++++++++++++++++ ::

:: 参数1为空的情况
if "%p1%"=="" (
	set "p1=/vp"
	goto process
)

:: 参数2为空的情况,验证参数1是否合法
if "%p2%"=="" (
	echo !p1!|findstr /bei "\/v \/p \/vp" >nul && goto process 
	echo !p1!|findstr /bei "r[-]*[0-9]*" >nul &&  (set "p2=!p1!" & set "p1=/vp" & goto process )
	echo !p1!|findstr /be "[0-9]*" >nul &&  (set "p2=!p1!" & set "p1=/vp" & goto process )
	goto showError	
)

:: 参数1和参数2都不为空的情况
echo %p1%|findstr /bei "\/v \/p \/vp" >nul || goto showError 
echo %p2%|findstr /bei "r[-]*[0-9]*" >nul && goto process
echo %p2%|findstr /be "[0-9]*" >nul && goto process
goto showError

:process
set "logfile=!curdatetime!.log"

:: +++++++++++++++++++++++++++++++++ 参数2为空的情况-开始 +++++++++++++++++++++++++++++++++++++++++
if "%p2%"=="" (
	echo. ++++++++++++++++++++++++++++++设置++++++++++++++++++++++++++++
	
	:: 备份路径的前缀
	set "backupPathPrefix=!parentdir!\backup\!curdatetime!"
	
	:: 备份所有的环境变量
	set >"!backupPathPrefix!.set.backup"
	
	
	:: 单独备份Path环境变量
	path >"!backupPathPrefix!.epath.backup"
	
	:: 单独备份需要设置的环境变量(在配置文件里面配置的 conf\evar.conf)
	for /f "usebackq eol=# tokens=1,* delims==" %%a in ("!parentdir!\conf\evar.conf") do (
		echo.%%a>>"!backupPathPrefix!.evar.backup"
	)
	
	echo !p1!|findstr /bei "\/v \/vp" >nul && set "set_evar=true" 
	echo !p1!|findstr /bei "\/p \/vp" >nul && set "set_epath=true" 
	
	
	:: 设置环境变量
	if defined set_evar (
		for /f "usebackq eol=# tokens=1,* delims==" %%a in ("!parentdir!\conf\evar.conf") do (
			call "!parentdir!\bin\evar.bat" %%a "%%b"
		)
	)
	
	:: 设置Path变量的值
	if defined set_epath (
		for /f "usebackq eol=#" %%a in ("!parentdir!\conf\epath.conf") do (
			set "conf_epath_val=%%a;!conf_epath_val!"
		)
		set "newpath=!conf_epath_val!%Path%"
		echo. set the new system variable PATH
		echo. PATH=!newpath!
		wmic ENVIRONMENT where "name='Path' and username='<system>'" set VariableValue="!conf_epath_val!%Path%" >nul
	)
	
	goto end
)
:: +++++++++++++++++++++++++++++++++ 参数2为空的情况-结束 +++++++++++++++++++++++++++++++++++++++++


:: +++++++++++++++++++++++++++++++++ 存在参数2的情况-开始 +++++++++++++++++++++++++++++++++++++++++
echo. ++++++++++++++++++++++++++++++还原++++++++++++++++++++++++++++

set "backupdir=!parentdir!\backup"

:: 恢复第几个文件的数据
set "revertTo=!p2:r=!"
set /a "revertTo=!revertTo:-=!"

echo !p1!|findstr /bei "\/v \/vp" >nul && set "get_evar_backup_file_cmd=dir !backupdir!\*.evar.backup /d /b"
echo !p1!|findstr /bei "\/p \/vp" >nul && set "get_epath_backup_file_cmd=dir !backupdir!\*.epath.backup /d /b"

:: 如果是从后往前恢复
if /i "!p2:~0,2!" EQU "r-" (
	echo !p1!|findstr /bei "\/v \/vp" >nul && set "get_evar_backup_file_cmd=!get_evar_backup_file_cmd! |sort /r"
	echo !p1!|findstr /bei "\/p \/vp" >nul && set "get_epath_backup_file_cmd=!get_epath_backup_file_cmd! |sort /r"
)

:: 找到需要的备份文件
if defined get_evar_backup_file_cmd (
	set /a "idx=0"
	for /f "usebackq" %%i in (`!get_evar_backup_file_cmd!`) do (
		set /a "idx+=1"	
		if "!revertTo!" EQU "!idx!" (
			set "evar_backup_file=%%i"
		)
	)
)

if defined get_epath_backup_file_cmd (
	set /a "idx=0"
	for /f "usebackq" %%i in (`!get_epath_backup_file_cmd!`) do (
		set /a "idx+=1"	
		if "!revertTo!" EQU "!idx!" (
			set "epath_backup_file=%%i"
		)
	)
)


:: 恢复到指定的版本
if not defined evar_backup_file (
	if not defined epath_backup_file (
		echo !p1!|findstr /bei "\/v \/vp" >nul && set "evar_backup_file=!p2!.evar.backup"
		echo !p1!|findstr /bei "\/p \/vp" >nul && set "epath_backup_file=!p2!.epath.backup"
	)
)

:: 进行恢复

:: 恢复环境变量
if defined evar_backup_file (
	:: 对照xx.set.backup 和 xx.evar.backup 文件
	if not exist "!backupdir!\!evar_backup_file!" (
		echo. 错误提示：没有找到备份文件 !backupdir!\!evar_backup_file!
		goto end
	)
	set set_backup_file=!backupdir!\!evar_backup_file:evar=set!
	echo 从备份文件 !set_backup_file! 中还原环境变量:开始
	echo.
	:: 遍历 evar_bakcup_file
	for /f "usebackq eol=#" %%i in ("!backupdir!\!evar_backup_file!") do (
		:: 当前需要被恢复的环境变量在set_bakcup_file文件中是否存在
		set "existEvar=0"
		for /f "usebackq eol=# tokens=1,* delims==" %%a in ("!set_backup_file!") do (
			
			if /i "%%i" EQU "%%a" (
				:: 如果存在就还原
				echo 备份文件中存在环境变量%%i, 正在还原: %%i=%%b
				wmic ENVIRONMENT where "name='%%i' and username='<system>'" set VariableValue="%%b"
				set "existEvar=1"
			)
		)
		
		:: 如果不存在就删除
		if "!existEvar!"=="0" (
			echo 备份文件中不存在环境变量%%i, 正在删除: %%i
			wmic ENVIRONMENT where "name='%%i'" delete >nul
		)
	)
	echo.
	echo.从备份文件 !set_backup_file! 中还原环境变量:结束
)

:: 恢复Path变量
echo.
echo.---------------------------------------------------------------------
echo.
if defined epath_backup_file (
	set epath_backup_file=!backupdir!\!epath_backup_file!
	
	if not exist "!epath_backup_file!" (
		echo. 错误提示：没有找到备份文件 !epath_backup_file!
		goto end
	)
	
	echo.从备份文件 !epath_backup_file! 中还原系统Path变量:开始
	echo.
	for /f "usebackq eol=# tokens=1,* delims==" %%a in ("!epath_backup_file!") do (
		echo 还原内容: %%a=%%b
		wmic ENVIRONMENT where "name='%%a' and username='<system>'" set VariableValue="%%b" >nul
	)
	echo.
	echo.从备份文件 !epath_backup_file! 中还原系统Path变量:结束
)

goto end
:: +++++++++++++++++++++++++++++++++ 存在参数2的情况-结束 +++++++++++++++++++++++++++++++++++++++++

:showError
echo. Error: parameter fromater %p1% %p2%
echo. The correct format : 

:showHelp
echo. %0 [/v or /p or /vp] [r[-]revertTo or revertVersion]
echo. v: 系统环境变量
echo. p: 系统变量Path
echo. vp: 系统环境变量和系统变量Path
echo. r: 恢复, 如果没有r参数就是表示是设置
echo. revertTo: 恢复第几个文件的数据,例如：r1, r2, r5 或者 r-1, r-2, r-5
echo. -: 从后往前开始算起，例如：恢复到上一次设置之前的状态就是 r-1
echo. revertVersion: 恢复到指定的版本,backup目录下的文件前缀数字表示版本号 例如：2015071217435571 

:end
pause
endlocal

