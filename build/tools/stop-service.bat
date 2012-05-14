@echo off

if [%1] == [] goto Usage

:ResolveInitialState
sc query %1 | find "STATE" | find "STOPPED" >NUL
if ERRORLEVEL 0 if not ERRORLEVEL 1 goto StoppedService
sc query %1 | find "STATE" | find "RUNNING" >NUL
if ERRORLEVEL 0 if not ERRORLEVEL 1 goto StopService

sc query %1 | find "STATE"
call :wait 2000
goto ResolveInitialState

:StopService
sc stop %1 >NUL
if ERRORLEVEL 1 (
	echo Could not stop %1 service.
	goto ExitWithError
)
echo %1 is stopping
goto StoppingService

:StoppingServiceDelay
call :wait 2000

:StoppingService
sc query %1 | find "STATE" | find "STOPPED" >NUL
if ERRORLEVEL 1 goto StoppingServiceDelay
goto StoppedService

:StoppedService
echo %1 is stopped
goto ExitClean

:Usage
echo %0 [service name]
goto ExitWithError

:wait
ping 1.1.1.1 -n 1 -w %1 >NUL

:ExitClean
exit /B 0

:ExitWithError
exit /B 1
