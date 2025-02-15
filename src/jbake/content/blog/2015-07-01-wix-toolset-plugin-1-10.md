---
layout: post
title: "Wix Toolset plugin 1.10 for Jenkins released"
creator: rollinhand
date: 2015-07-01
category: Allgemein
---
A new version of Wix Toolset plugin was released on June 1st. The new version is automatically 
available via Jenkins update manager. This announcement describes the latest changes.

<!--more-->

### Changes
* Minimum required version of Jenkins is now 1.579
* Installation path can be left empty. Wix Toolset plugin is then expecting that the Wix Tools are added to the system environment variable *PATH* on Windows master or slave.
* **github #4:** Environment variables containing pathes are no longer rejected by default.
* Some refactoring and code cleanup

### Bugfixes
* Environment variables which contain a path which ends on a backslash are now escaped. This will avoid errors like *CNDL0103 : The system cannot find the file 'XXX' with type 'Source'*.
* **github #5:** The commands calling candle.exe and light.exe are now using relative paths instead of absolute paths. That should avoid a leading slash before the command if Jenkins master is running on Linux.

***
A complete list of all changes is available at [GitHub](https://github.com/jenkinsci/wix-plugin/blob/master/CHANGELOG.md).
