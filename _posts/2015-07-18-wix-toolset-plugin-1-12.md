---
layout: post
title: "Wix Toolset plugin 1.12 for Jenkins released"
creator: rollinhand
date: 2015-07-18
category: General
---
A new version of Wix Toolset plugin was released on July 18th. The new version is 
automatically available via Jenkins update manager. This announcement describes the latest changes.
<!--more-->
Release 1.12 is a minor bugfix release with fixes to the internal logging routines and the 
handling of directory paths:

* **github #6:** A percent in a path or environment variable could cause the plugin to crash
 if the values where printed with the internal ToolsetLogger. The internal printf was changed to println.
* **github #6:** The bugfix for handling of directory paths introduced with 1.11 was 
changed again. If a directory path ends with a backslash, the last backslash in directory path is 
removed. Otherwise a quotation mark could get casted by the backslash if directory path 
contains whitespaces and that would fail the Jenkins Process Builder.

***
A complete list of all changes is available at [GitHub](https://github.com/jenkinsci/wix-plugin/blob/master/CHANGELOG.md).
