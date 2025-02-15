---
layout: post
title: "Wix Toolset plugin 1.5 for Jenkins released"
creator: rollinhand
date: 2014-06-25
category: Allgemein
---
A new version of Wix Toolset plugin was released today. The new version will be automatically available via Jenkins update manager in a few hours. This announcement describes the latest changes.
<!--more-->
## Changes between Wix Toolset plugin 1.4 and 1.5
### [Define MSI package name](https://github.com/jenkinsci/wix-plugin/blob/master/CHANGELOG.md#define-msi-package-name)
It is now possible to define a filename for the MSI package. If this *Advanced Setting* is left 
blank the MSI package name defaults to *setup.msi*. Environment variables (as long as defined) 
are expanded to their value. A package name like setup-${BUILD_NUMBER}.msi results for e.g. to setup-40.msi.

### [Define defaults for architecture](https://github.com/jenkinsci/wix-plugin/blob/master/CHANGELOG.md#define-defaults-for-architecture)
Set architecture defaults for package, components, etc. values: x86, x64, or ia64 (default: x86)

### [Minor changes](https://github.com/jenkinsci/wix-plugin/blob/master/CHANGELOG.md#minor-changes)
* On the system configuration page the plugin is now called Wix Toolset instead of Windows Installer Builder.
* Extended validation of installation directory. Checks now if directory contains compiler candle.exe und linker light.exe.
* English and german messages depending on your system settings.

A complete list of all changes is available at [GitHub](https://github.com/jenkinsci/wix-plugin/blob/master/CHANGELOG.md).
