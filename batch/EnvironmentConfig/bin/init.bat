@echo off
setlocal enabledelayedexpansion

set "p1=%1"
set "p2=%2"

if /i "%p1%" EQU "-help" (
	goto showHelp
)

:: ++++++++++++++++++++++++++++++��ȡ�ϼ�·��-��ʼ++++++++++++++++++++++++++++++++ ::
set curdir=%cd%
cd.. >nul
set "parentdir=%cd%"
cd /d "%curdir%" >nul
:: ++++++++++++++++++++++++++++++��ȡ�ϼ�·��-����++++++++++++++++++++++++++++++++ ::


:: ++++++++++++++++++++++++++++++��ȡ��ǰʱ��-��ʼ++++++++++++++++++++++++++++++++ ::
:: ��ǰ����ʱ��
set "curdatetime="
:: ƴ�ӵ�ǰ����
for /f "usebackq tokens=1-3 delims=-/. " %%a in (`date /t`) do (
	set curdatetime=%%a%%b%%c
)
:: ƴ�ӵ�ǰʱ��
for /f "tokens=1-4 delims=:-/. " %%a in ("%time%") do (
	set curdatetime=!curdatetime!%%a%%b%%c%%d
)
:: ++++++++++++++++++++++++++++++��ȡ��ǰʱ��-����++++++++++++++++++++++++++++++++ ::

:: ����1Ϊ�յ����
if "%p1%"=="" (
	set "p1=/vp"
	goto process
)

:: ����2Ϊ�յ����,��֤����1�Ƿ�Ϸ�
if "%p2%"=="" (
	echo !p1!|findstr /bei "\/v \/p \/vp" >nul && goto process 
	echo !p1!|findstr /bei "r[-]*[0-9]*" >nul &&  (set "p2=!p1!" & set "p1=/vp" & goto process )
	echo !p1!|findstr /be "[0-9]*" >nul &&  (set "p2=!p1!" & set "p1=/vp" & goto process )
	goto showError	
)

:: ����1�Ͳ���2����Ϊ�յ����
echo %p1%|findstr /bei "\/v \/p \/vp" >nul || goto showError 
echo %p2%|findstr /bei "r[-]*[0-9]*" >nul && goto process
echo %p2%|findstr /be "[0-9]*" >nul && goto process
goto showError

:process
set "logfile=!curdatetime!.log"

:: +++++++++++++++++++++++++++++++++ ����2Ϊ�յ����-��ʼ +++++++++++++++++++++++++++++++++++++++++
if "%p2%"=="" (
	echo. ++++++++++++++++++++++++++++++����++++++++++++++++++++++++++++
	
	:: ����·����ǰ׺
	set "backupPathPrefix=!parentdir!\backup\!curdatetime!"
	
	:: �������еĻ�������
	set >"!backupPathPrefix!.set.backup"
	
	
	:: ��������Path��������
	path >"!backupPathPrefix!.epath.backup"
	
	:: ����������Ҫ���õĻ�������(�������ļ��������õ� conf\evar.conf)
	for /f "usebackq eol=# tokens=1,* delims==" %%a in ("!parentdir!\conf\evar.conf") do (
		echo.%%a>>"!backupPathPrefix!.evar.backup"
	)
	
	echo !p1!|findstr /bei "\/v \/vp" >nul && set "set_evar=true" 
	echo !p1!|findstr /bei "\/p \/vp" >nul && set "set_epath=true" 
	
	
	:: ���û�������
	if defined set_evar (
		for /f "usebackq eol=# tokens=1,* delims==" %%a in ("!parentdir!\conf\evar.conf") do (
			call "!parentdir!\bin\evar.bat" %%a "%%b"
		)
	)
	
	:: ����Path������ֵ
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
:: +++++++++++++++++++++++++++++++++ ����2Ϊ�յ����-���� +++++++++++++++++++++++++++++++++++++++++


:: +++++++++++++++++++++++++++++++++ ���ڲ���2�����-��ʼ +++++++++++++++++++++++++++++++++++++++++
echo. ++++++++++++++++++++++++++++++��ԭ++++++++++++++++++++++++++++

set "backupdir=!parentdir!\backup"

:: �ָ��ڼ����ļ�������
set "revertTo=!p2:r=!"
set /a "revertTo=!revertTo:-=!"

echo !p1!|findstr /bei "\/v \/vp" >nul && set "get_evar_backup_file_cmd=dir !backupdir!\*.evar.backup /d /b"
echo !p1!|findstr /bei "\/p \/vp" >nul && set "get_epath_backup_file_cmd=dir !backupdir!\*.epath.backup /d /b"

:: ����ǴӺ���ǰ�ָ�
if /i "!p2:~0,2!" EQU "r-" (
	echo !p1!|findstr /bei "\/v \/vp" >nul && set "get_evar_backup_file_cmd=!get_evar_backup_file_cmd! |sort /r"
	echo !p1!|findstr /bei "\/p \/vp" >nul && set "get_epath_backup_file_cmd=!get_epath_backup_file_cmd! |sort /r"
)

:: �ҵ���Ҫ�ı����ļ�
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


:: �ָ���ָ���İ汾
if not defined evar_backup_file (
	if not defined epath_backup_file (
		echo !p1!|findstr /bei "\/v \/vp" >nul && set "evar_backup_file=!p2!.evar.backup"
		echo !p1!|findstr /bei "\/p \/vp" >nul && set "epath_backup_file=!p2!.epath.backup"
	)
)

:: ���лָ�

:: �ָ���������
if defined evar_backup_file (
	:: ����xx.set.backup �� xx.evar.backup �ļ�
	if not exist "!backupdir!\!evar_backup_file!" (
		echo. ������ʾ��û���ҵ������ļ� !backupdir!\!evar_backup_file!
		goto end
	)
	set set_backup_file=!backupdir!\!evar_backup_file:evar=set!
	echo �ӱ����ļ� !set_backup_file! �л�ԭ��������:��ʼ
	echo.
	:: ���� evar_bakcup_file
	for /f "usebackq eol=#" %%i in ("!backupdir!\!evar_backup_file!") do (
		:: ��ǰ��Ҫ���ָ��Ļ���������set_bakcup_file�ļ����Ƿ����
		set "existEvar=0"
		for /f "usebackq eol=# tokens=1,* delims==" %%a in ("!set_backup_file!") do (
			
			if /i "%%i" EQU "%%a" (
				:: ������ھͻ�ԭ
				echo �����ļ��д��ڻ�������%%i, ���ڻ�ԭ: %%i=%%b
				wmic ENVIRONMENT where "name='%%i' and username='<system>'" set VariableValue="%%b"
				set "existEvar=1"
			)
		)
		
		:: ��������ھ�ɾ��
		if "!existEvar!"=="0" (
			echo �����ļ��в����ڻ�������%%i, ����ɾ��: %%i
			wmic ENVIRONMENT where "name='%%i'" delete >nul
		)
	)
	echo.
	echo.�ӱ����ļ� !set_backup_file! �л�ԭ��������:����
)

:: �ָ�Path����
echo.
echo.---------------------------------------------------------------------
echo.
if defined epath_backup_file (
	set epath_backup_file=!backupdir!\!epath_backup_file!
	
	if not exist "!epath_backup_file!" (
		echo. ������ʾ��û���ҵ������ļ� !epath_backup_file!
		goto end
	)
	
	echo.�ӱ����ļ� !epath_backup_file! �л�ԭϵͳPath����:��ʼ
	echo.
	for /f "usebackq eol=# tokens=1,* delims==" %%a in ("!epath_backup_file!") do (
		echo ��ԭ����: %%a=%%b
		wmic ENVIRONMENT where "name='%%a' and username='<system>'" set VariableValue="%%b" >nul
	)
	echo.
	echo.�ӱ����ļ� !epath_backup_file! �л�ԭϵͳPath����:����
)

goto end
:: +++++++++++++++++++++++++++++++++ ���ڲ���2�����-���� +++++++++++++++++++++++++++++++++++++++++

:showError
echo. Error: parameter fromater %p1% %p2%
echo. The correct format : 

:showHelp
echo. %0 [/v or /p or /vp] [r[-]revertTo or revertVersion]
echo. v: ϵͳ��������
echo. p: ϵͳ����Path
echo. vp: ϵͳ����������ϵͳ����Path
echo. r: �ָ�, ���û��r�������Ǳ�ʾ������
echo. revertTo: �ָ��ڼ����ļ�������,���磺r1, r2, r5 ���� r-1, r-2, r-5
echo. -: �Ӻ���ǰ��ʼ�������磺�ָ�����һ������֮ǰ��״̬���� r-1
echo. revertVersion: �ָ���ָ���İ汾,backupĿ¼�µ��ļ�ǰ׺���ֱ�ʾ�汾�� ���磺2015071217435571 

:end
pause
endlocal

