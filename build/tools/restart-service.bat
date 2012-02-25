@echo off

if [%1] == [] goto Usage

:ResolveInitialState
sc query %1 | find "STATE" | find "STOPPED" >NUL
if ERRORLEVEL 0 if not ERRORLEVEL 1 goto StartService
sc query %1 | find "STATE" | find "RUNNING" >NUL
if ERRORLEVEL 0 if not ERRORLEVEL 1 goto RestartService

sc query %1 | find "STATE"
call :wait 2000
goto ResolveInitialState

:StartService
sc start %1 >NUL
if ERRORLEVEL 1 (
	echo Could not start service.
	goto ExitWithError
)
echo %1 is starting
goto StartingService

:StartingServiceDelay
call :wait 2000

:StartingService
sc query %1 | find "STATE" | find "RUNNING" >NUL
if ERRORLEVEL 1 goto StartingServiceDelay
echo %1 is running
goto ExitClean

:RestartService
sc stop %1 >NUL
if ERRORLEVEL 1 (
	echo Could not stop service.
	goto ExitWithError
)
echo %1 is stopping
goto StoppingService

:StoppingServiceDelay
call :wait 2000

:StoppingService
sc query %1 | find "STATE" | find "STOPPED" >NUL
if ERRORLEVEL 1 goto StoppingServiceDelay
echo %1 is stopped
call :wait 15000
goto StartService

:Usage
echo %0 [service name]
goto ExitWithError

:wait
ping 1.1.1.1 -n 1 -w %1 >NUL

:ExitClean
exit /B 0

:ExitWithError
exit /B 1