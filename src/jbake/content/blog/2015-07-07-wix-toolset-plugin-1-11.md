~~~~~~
type=post
title=Wix Toolset plugin 1.11 for Jenkins released
creator=rollinhand
date=2015-07-07
category=Allgemein
~~~~~~
A new version of Wix Toolset plugin was released on July 8th. The new version is automatically 
available via Jenkins update manager. This announcement describes the latest changes.
<!--more-->
Release 1.11 is a major bugfix release due to problems with running Wix Toolset on a Windows slave:

* **github #5:** The commands calling candle.exe and light.exe are now using supporting Jenkins 
remote path and the native Jenkins Launcher for remote processes. A lot of thanks go to @pulphix who 
tested and tested and tested...

***
A complete list of all changes is available at [GitHub](https://github.com/jenkinsci/wix-plugin/blob/master/CHANGELOG.md).
