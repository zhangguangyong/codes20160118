:: **************** Set Environment Variable **************** ::

:: Parameter name [value] [/d delete]

@echo off

:: receiving parameters
set "p1=%1"
set "p2=%2"

if "%p1%"=="" (
	goto showError
)

:: first remove
echo. delete the environment variable %p1%
wmic environment where "name='%p1%'" delete >nul

:: if the value is set
if not "%p2%"=="" (
	echo. set the environment variable %p1%=%p2%
	wmic environment create name="%p1%",username="<system>",VariableValue="%p2%" >nul
)

goto end

:showError
echo. Error: parameter fromater %p1% %p2%
echo. The correct format : %0 name [value]

:end



