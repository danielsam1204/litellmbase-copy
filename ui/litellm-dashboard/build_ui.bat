    @echo off
    SETLOCAL ENABLEEXTENSIONS

    :: Print contents of ui_colors.json
    echo Contents of ui_colors.json:
    type ui_colors.json

    :: Run npm build
    call npm run build
    IF ERRORLEVEL 1 (
        echo Build failed. Deployment aborted.
        exit /b 1
    )

    echo Build successful. Copying files... To the Backend

    :: Echo current directory
    echo.
    cd

    :: Set destination directory
    SET "destination_dir=..\..\litellm\proxy\_experimental\out"

    :: Remove existing files in the destination directory
    IF EXIST "%destination_dir%" (
        rmdir /S /Q "%destination_dir%"
        mkdir "%destination_dir%"
    )

    :: Copy output directory contents to the destination
    xcopy /E /I /Y ".\out\*" "%destination_dir%\"

    echo Deployment completed.