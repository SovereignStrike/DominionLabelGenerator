@echo off
:: Set code page to UTF-8 to read the CSV correctly
chcp 65001 >nul
setlocal enableDelayedExpansion
for /f "skip=1 usebackq tokens=1-10 delims=," %%a in (data.csv) do (
    echo %%~a
    if %%~a == Base_Game (
    echo Processing: %%~c
    if not exist %%a mkdir %%a
    if not exist %%a\%%b mkdir %%a\%%b
    rem Create a temporary parameters file in UTF-8
    echo Expansion = "%%~a"; > params.scad
    echo Card_Name = "%%~c"; >> params.scad
    echo Cost = %%~d; >> params.scad
    echo Cost_Icon = "%%~e"; >> params.scad
    echo Hide_Cost = %%~f; >> params.scad
    echo Second_Cost = %%~g; >> params.scad
    echo Second_Cost_Icon = "%%~h"; >> params.scad
    echo Hide_Second_Cost = %%~i; >> params.scad
    echo Tray_Height = %%~j; >> params.scad
    
    rem Call OpenSCAD ( better than -D flags)
    openscad -o "%%a/%%b/output_%%~c.stl" --export-format binstl label_parameter.scad
    copy "params.scad" "%%a/%%b/params_%%~c.scad"
    echo -----------------)
)

pause