@Echo off
echo Calliope Deployment Tool  Ver. 0.02
echo (c) 2018 Jan Ischebeck 
echo ................................... 

If /I "%~x1" neq ".hex" (
    echo ERR: Nur .hex Dateien sind erlaubt^!
    Pause
    exit 1
) 

set FOUND="No"
SETLOCAL EnableDelayedExpansion
for /F "usebackq tokens=1,2,3 " %%i in (`wmic logicaldisk get caption^,drivetype^,volumename 2^>NUL`) do (
    if "%%j" equ "2" (
        if "%%k" equ "MINI" (
            echo ^>^>^> Calliope gefunden (Laufwerk %%i^)
            IF exist "%~f1" (
                echo Copy %1 to %%i
                copy "%~f1" %%i
                Pause
            ) ELSE (
                echo ^>^>^> Datei %1 nicht vorhanden
                Pause
            )
            set FOUND="Yes"
        )
    )
)

IF %FOUND% neq "Yes" (
    Echo ERR: Callipoe wurde nicht gefunden^!
    Pause
    Exit 2
) 