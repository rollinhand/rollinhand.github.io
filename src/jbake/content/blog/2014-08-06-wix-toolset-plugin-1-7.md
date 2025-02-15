~~~~~~
type=post
title=Wix Toolset plugin 1.7 for Jenkins released
creator=rollinhand
date=2014-08-06
category=Allgemein
~~~~~~
A new version of Wix Toolset plugin was released today. The new version will be automatically 
available via Jenkins update manager in a few hours. This announcement describes the latest changes.
<!--more-->
### Changes between Wix Toolset plugin 1.5 and 1.7
1. Versions prior to 1.7 had problems with whitespaces in the installation directory of 
WiX Toolset. The Builder for executing the command is changed to wrap the commands 
candle.exe and light.exe with double quotes.
2. Version 1.5 contained a critical error which made it impossible to 
build any setup with WiX Toolset. This error was produced while resolving a translated message.

***
A complete list of all changes is available at [GitHub](https://github.com/jenkinsci/wix-plugin/blob/master/CHANGELOG.md).
