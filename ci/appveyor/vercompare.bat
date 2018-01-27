@echo off

:: left: the installed version
:: right: the requiered min version

:: return 0 when installed version < requiered version
:: return 1 when installed version >= requiered version

SETLOCAL


set left=%1
set right=%2

for /f "tokens=1-3 delims=." %%a in (%left%) do (
  set VersionLeftMajor=%%a
  set VersionLeftMinor=%%b
  set VersionLeftBuild=%%c
)


for /f "delims=. tokens=1,2,3" %%a in ("%right%") do (
  set VersionRightMajor=%%a
  set VersionRightMinor=%%b
  set VersionRightBuild=%%c
)


:: examples
:: 3.2.12 > 2.3.1    ===> 1  installed does fulfill requiered
if "%VersionLeftMajor%" GTR "%VersionRight.Major%" (
    EXIT /B 0
)

:: 1.2.12 > 3.3.1    ===> 0  installed does not fulfill requiered
if %VersionLeftMajor% LSS %VersionRightMajor% (
    EXIT /B 1
)

:: the Major's are equal
:: 3.5.12 >= 3.3.1  ===> 1  installed does fulfill requiered
if %VersionLeftMinor% GEQ %VersionRightMinor% (
    EXIT /B 0
)

:: 3.2.12 > 3.3.1    ===> 0  installed does not fulfill requiered regardless of build
EXIT /B 1

:exit
exit /b
