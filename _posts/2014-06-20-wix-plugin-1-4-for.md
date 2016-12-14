---
layout: post
title: "WiX Plugin 1.4 for Jenkins released"
creator: rollinhand
date: 2014-06-20
category: General
icon: jenkins.png
---
Today I released a new version of the WiX plugin for Jenkins. This announcement describes the changes between the current and the former 1.3 release. The new version will be available on Jenkins update manager in a few hours.
<!--more-->
### Changes
1. **Ant-style source pattern:** You can now define Ant-style source pattern instead of using the fully name of a source file. While using a source pattern it is now possible for Wix plugin to compile more than one source file into a single *wixobj*-file. Simply use a pattern like ***/*.wxs* to compile all available WiX source scripts.
2. **Environment variables:** Defined environment variables in a build job are now passed as parameters to WiX Compiler (candle.exe) and WiX Linker (light.exe). This feature has severals restrictions. Environment variables containing pathes and illegal characters are not passed as parameters.
3. **Refactoring:** A lot of code was rewritten for a better performance and easier code extension.
