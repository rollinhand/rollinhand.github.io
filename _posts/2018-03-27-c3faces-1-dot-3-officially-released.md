---
layout: post
title: C3Faces 1.3 officially released
date: 2018-03-27
category: Entwicklung 
tags: Java C3Faces JSF 
---
C3Faces is a chart library for JSF based on c3.js. I want to announce the third
official version of this library released to 
[Maven central](https://search.maven.org/#artifactdetails%7Corg.kivio%7Cc3faces%7C1.0%7Cjar)
coming with a small fix for older versions of JSF and pre-defined colors and themes.

<!--more-->

## Fix for older versions of JSF
The configuration file _faces-config.xml_ was extended and is now declaring 
_components_ from the taglib.
This requirement is defined by older versions of JSF and Spring Boot. Background
information demanding this fix can be found
[here](https://docs.oracle.com/cd/E19575-01/819-3669/bnawo/index.html).

## Pre-defined colors and themes
It is now possible to select pre-defined colors and themes for much
more harmonius colours in charts. Therefore the classes _C3Color_ and
_C3Theme_ were introduced. _C3Theme_ contains themes used in Microsoft Excel
or LibreOffice Spreadsheet. Showcase does not reflect this change so feel free
playing around with this classes.

## Further information 
Changelog about further changes between previous version and the present one
can be found in the official [Changelog](https://github.com/rollinhand/c3faces/blob/master/CHANGELOG) 
in the GitHub repository.

Have fun while playing around with C3Faces and if you find any issues or have
suggestions for new features please [leave a comment](https://github.com/rollinhand/c3faces/issues).
