@echo off
chcp 65001 >nul
title MGYV GAMEs — Installation

echo.
echo  ╔══════════════════════════════════════╗
echo  ║       MGYV GAMEs — Launcher          ║
echo  ║       Installation automatique       ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Téléchargement en cours...
echo.

:: ── CONFIGURATION ──
:: Remplace ce lien par le lien direct vers ton ZIP sur GitHub Releases
set DOWNLOAD_URL=https://github.com/Maxence-99/MGYV-GAMEs-launcher-site/releases/download/v1.0.0/MGYV-GAMEs.zip
set INSTALL_DIR=%USERPROFILE%\MGYV-GAMEs
set ZIP_FILE=%TEMP%\MGYV-GAMEs.zip

:: ── TÉLÉCHARGEMENT ──
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $client = New-Object System.Net.WebClient; $client.DownloadFile('%DOWNLOAD_URL%', '%ZIP_FILE%'); Write-Host ' Téléchargement terminé !'}"

if not exist "%ZIP_FILE%" (
    echo.
    echo  ERREUR : Le téléchargement a échoué.
    echo  Vérifie ta connexion internet.
    pause
    exit /b 1
)

echo.
echo  Extraction en cours...

:: ── EXTRACTION ──
if exist "%INSTALL_DIR%" rmdir /s /q "%INSTALL_DIR%"
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%INSTALL_DIR%' -Force; Write-Host ' Extraction terminée !'"

:: ── NETTOYAGE ──
del "%ZIP_FILE%" >nul 2>&1

:: ── RACCOURCI BUREAU ──
echo.
echo  Création du raccourci bureau...

powershell -Command "& {$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut([System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'MGYV GAMEs.lnk')); $Shortcut.TargetPath = '%INSTALL_DIR%\MGYV GAMEs.exe'; $Shortcut.WorkingDirectory = '%INSTALL_DIR%'; $Shortcut.Save()}"

echo.
echo  ╔══════════════════════════════════════╗
echo  ║   Installation terminée avec succès  ║
echo  ║                                      ║
echo  ║   Un raccourci a été créé sur        ║
echo  ║   ton Bureau.                        ║
echo  ╚══════════════════════════════════════╝
echo.

:: ── LANCEMENT ──
set /p LAUNCH="  Lancer MGYV GAMEs maintenant ? (O/N) : "
if /i "%LAUNCH%"=="O" (
    start "" "%INSTALL_DIR%\MGYV GAMEs.exe"
)

echo.
echo  Merci d'avoir installé MGYV GAMEs !
timeout /t 3 >nul
exit
