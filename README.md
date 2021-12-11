# WiX Installer for Flutter App Example

Demonstrate how to use [WiX toolset](https://wixtoolset.org/) to create an
installer for Flutter Windows app.

Great artists ship, so do developers. Once you build a Windows app using
Flutter, the next step is to distribute your app to your testers and users.
There are dozens of tools to let you create installers on Windows, and we use
Wix toolset here.

## Requirement

- A computer running Windows, and Flutter development tools installed, such as
  Flutter runtime, Visual Studio, and Flutter IDE like Android Studio, Visual
  Studio Code or IntelliJ.
- Wix toolset installed. [Download link](https://github.com/wixtoolset/wix3/releases/).
  We assume you install wixtool kit v3.11.2 at `C:\Program Files (x86)\WiX Toolset v3.11`.

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
bootstrap bundle, and they are declared in two files in the project, MSI.wxs and
Bundle.wxs. The MSI file does the task to copy the binaries to users' computers,
while the bootstrap bundle combines a set of installers, including our MSI file,
C++ runtime and other dependencies.


