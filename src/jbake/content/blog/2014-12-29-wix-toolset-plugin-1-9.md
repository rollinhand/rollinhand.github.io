~~~~~~
type=post
title=Wix Toolset plugin 1.9 for Jenkins released
creator=rollinhand
date=2014-12-29
category=Allgemein
~~~~~~
A new version of Wix Toolset plugin was released on December 19th. The new version is 
automatically available via Jenkins update manager. This announcement describes the latest changes.

<!--more-->

### Changes
* Automatic addition of environment variables as parameters to candle and light is now globally configurable.
* Administrators can decide which environment variables should not be taken into account as parameter.
* Every log file from WiX Toolset plugin is now prefixed with *wix*.

### Bugfixes
* An empty filename for the MSI output is expanded to *setup.msi*.
* Changed global settings are immediately active.

***
A complete list of all changes is available at [GitHub](https://github.com/jenkinsci/wix-plugin/blob/master/CHANGELOG.md).
