cd installer\wix\MSI
cmd /c del /F /Q bin

echo "Start to build the MSI file..."

"C:\Program Files (x86)\WiX Toolset v3.11\bin\candle.exe" MSI.wxs -out MSI.wixobj
cmd /c dir
"C:\Program Files (x86)\WiX Toolset v3.11\bin\light.exe" MSI.wixobj "C:\Program Files (x86)\WiX Toolset v3.11\bin\difxapp_x64.wixlib" -out bin\Release\MSI.msi -ext WixUIExtension -ext WixUtilExtension

cmd /c del /F /Q MSI.wixobj

echo "Start to build the Boostrap bundle..."

cd ..\Bundle
cmd /c del /F /Q  bin
"C:\Program Files (x86)\WiX Toolset v3.11\bin\candle.exe" Bundle.wxs -out Bundle.wixobj -ext WixBalExtension -ext WixUtilExtension
"C:\Program Files (x86)\WiX Toolset v3.11\bin\light.exe" Bundle.wixobj -out bin\Release\Bundle.exe -ext WixBalExtension -ext WixUtilExtension
del Bundle.wixobj
cmd /c explorer "bin\Release"
cd ..\..\..
