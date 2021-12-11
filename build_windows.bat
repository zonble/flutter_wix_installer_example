REM A simple build script.
@ECHO OFF
TITLE "Build Example App and Installer"

ECHO "=============================="
ECHO "= Start to build Example App ="
ECHO "=============================="

ECHO "Step 1 Clean"
@REM cmd /c git clean -f
@REM cmd /c flutter clean
cmd /c del installer\wix\Bundle\bin\Release\ArkSPRSimulator.wixpdb
cmd /c del installer\wix\Bundle\bin\Release\ArkSPRSimulator.exe
cmd /c del /F /Q build
if exist build\windows\runner\Debug (
    ECHO "Cannot delete build dir, is the app running in debug mode?"
    exit 1
)

ECHO "Step 2 Updates dependencies"
cmd /c flutter pub get

ECHO "Step 3 Build binary"
cmd /c flutter build windows --verbose

ECHO "Step 4 Build Installer"
call build_windows_installer_only

ECHO "DONE!"
