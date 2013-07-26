:user_configuration

:: Path to Flex SDK
set FLEX_SDK=D:\JULIEN\LIB\AirSDK
::set FLEX_SDK=E:\LIB\AirSDK

set AUTO_INSTALL_IOS=yes

:: Path to Android SDK
set ANDROID_SDK=D:\JULIEN\OTHER\FlashDev4.2.3\Tools\android
::set ANDROID_SDK=E:\SOFTS\FlashDevelop\Tools\android

:validation
if not exist "%FLEX_SDK%\bin" goto flexsdk
if not exist "%ANDROID_SDK%\platform-tools" goto androidsdk
goto succeed

:flexsdk
echo.
echo ERROR: incorrect path to Flex SDK in 'bat\SetupSDK.bat'
echo.
echo Looking for: %FLEX_SDK%\bin
echo.
if %PAUSE_ERRORS%==1 pause
exit

:androidsdk
echo.
echo ERROR: incorrect path to Android SDK in 'bat\SetupSDK.bat'
echo.
echo Looking for: %ANDROID_SDK%\platform-tools
echo.
if %PAUSE_ERRORS%==1 pause
exit

:succeed
set PATH=%PATH%;%FLEX_SDK%\bin
set PATH=%PATH%;%ANDROID_SDK%\platform-tools

