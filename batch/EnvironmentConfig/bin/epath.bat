:: **************** Set Environment Variable **************** ::

:: Parameter value  [/t]

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: receiving parameters
set "p1=%1"
set "p2=%2"

echo %p1%
goto end

if "%p1%"=="" (
	goto showError
)

if not "%p2%"=="" (
	if /i "%p2%" NEQ "/t" (
		goto showError
	) else (
		set "newpath=%Path%;!p1!"
	)
) else (
	set "newpath=!p1!;%Path%"
)

:: 把:符号转换为;
:: set "newpath=!newpath::=;!"
:: set "newpath=!newpath:"=!"

echo. new path is :
echo. !newpath!
echo. wmic ENVIRONMENT where "name='Path' and username='<system>'" set VariableValue="%newpath%"
goto end

:showError
echo. Error parameter fromater : 
echo. %0 %p1% %p2%
echo. The correct format : 
echo. %0 appendValue [/t Tail]

:end
endlocal

