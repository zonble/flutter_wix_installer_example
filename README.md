# WiX Installer for Flutter App Example

2921 (c) Weizhong Yang a.k.a zonble

![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

Demonstrate how to use [WiX toolset](https://wixtoolset.org/) to create an
installer for Flutter Windows app.

Great artists ship, so do developers. Once you build a Windows app using
Flutter, the next step is to distribute your app to your testers and users.
There are dozens of tools to let you create installers on Windows, and we use
Wix toolset here.

## Requirement

- A computer running Windows, and Flutter development tools installed, such as
  Flutter runtime, Visual Studio, and Flutter IDE like Android Studio, Visual
  Studio Code or IntelliJ. We assume that you are using Visual Studio 2019.
- Wix toolset installed. [Download link](https://github.com/wixtoolset/wix3/releases/).
  We assume you install WiX toolkit v3.11.2 at `C:\Program Files (x86)\WiX Toolset v3.11`.

## Getting Started

To see how to build an installer for the example flutter app, just run
`build_windows.bat` in the Terminal app.

Building a Windows installer could be a difficult task. An installer for a
FLutter app does not merely copy the files compiles by the `flutter build windows`
command, but also creates desktop and start menu shortcut, installs
dependencies, drivers, and so on. The installer should be also able to know
about system requirement, since Flutter Windows app could only run on 64 bit
Windows system.

Since Flutter app are built on C++ runtime on Windows, you have to distribute a
copy of C++ runtime with your Flutter app. Your app may have other dependencies
as well. If your app uses packages like
[webview_windows](https://pub.dev/packages/webview_windows) or
[desktop_webview_window](https://pub.dev/packages/desktop_webview_window), the
installer also has to install Microsoft's [WebView2
runtime](https://developer.microsoft.com/en-us/microsoft-edge/webview2/). To
build such a complex installer, we can use WiX, a powerful toolset.

There are two step to build our final product, to build an MSI file, and a
bootstrap bundle, and they are declared in two files in the project,
[MSI.wxs](https://github.com/zonble/flutter_wix_installer_example/blob/main/installer/wix/MSI/MSI.wxs) and
[Bundle.wxs](https://github.com/zonble/flutter_wix_installer_example/blob/main/installer/wix/Bundle/Bundle.wxs).
The MSI file does the task to copy the binaries to users' computers, while the
bootstrap bundle combines a set of installers, including our MSI file, C++
runtime and other dependencies.

You can use editors like VisualStudio Code to edit the files. Plug-ins like
[XML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-xml) and
[UUID Generator](https://marketplace.visualstudio.com/items?itemName=motivesoft.vscode-uuid-generator)
could make you to edit the files easier.

### MSI.wxs

The file demonstrate how to

- Copy files to users' computers.
- Create desktop shortcut.
- Create start menu shortcut.
- Write install folder to registry.

When starting working with the file, please change the name of the product an
manufacture to your app and your company, and then generate new UUID for each
component.

You may need to take care on the installation scope, you can choose to install
your app to each users app data folder, or machine wide program files folder by
changing the value of "InstallScope" to "perUser" or "perMachine". You also need
to change the path of the registry to "HKCU" or "HKLM" accordingly.

Once you add new plugins and new assets, you need to edit the file to include
the added files.

### Bundle.wxs

The example demonstrates how to install our MSI file and C++ runtime in a single
bundle. If you want to install WebView2 runtime with your Flutter app, you can
add the following lines as a fragment to the file.

```xml
<Fragment>
    <PackageGroup Id="WebView2">
        <ExePackage Id="DownloadAndInvokeBootstrapper" Name="Install Microsoft WebView2 Runtime" Cache="no" Compressed="no" PerMachine="yes" Vital="no" DownloadUrl="https://go.microsoft.com/fwlink/p/?LinkId=2124703" SourceFile="..\..\MicrosoftEdgeWebView2RuntimeInstallerX64.exe" InstallCommand=" /silent /install" InstallCondition="NOT (REMOVE OR WVRTInstalled)">
            <RemotePayload ProductName="MicrosoftEdgeWebview2Setup" Description="Microsoft Edge WebView2 Update Setup" CertificatePublicKey="1392A8505C3B192F62311EA9005E49C1B5358F6B" Hash="82B42348804E8D82C773DC3391B691712BB1B388" Size="1815832" Version="1.3.135.41" />
        </ExePackage>
<ExePackage Id="DownloadAndInvokeBootstrapper" Name="Install Microsoft WebView2 Runtime" Cache="no" Compressed="yes" PerMachine="yes" Vital="no" SourceFile="..\..\MicrosoftEdgeWebView2RuntimeInstallerX64.exe" InstallCommand=" /silent /install" InstallCondition="NOT (REMOVE OR WVRTInstalled)" />
</PackageGroup>
```

And update the installation chain

```xml
<Chain DisableSystemRestore="yes">
    <PackageGroupRef Id="VCRuntime" />
    <PackageGroupRef Id="WebView2" />
    <PackageGroupRef Id="InstallerPackages" />
</Chain>
```

## License

The example is released under MIT license.
