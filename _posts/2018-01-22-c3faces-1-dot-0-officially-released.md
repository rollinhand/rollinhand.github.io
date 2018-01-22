---
layout: post
title: C3Faces 1.0 officially released
date: 2018-01-22
category: Entwicklung
tags: Java C3Faces JSF
---
C3Faces is a chart library for JSF based on c3.js. I want to announce the first
official version of this library released to [Maven central](https://search.maven.org/#artifactdetails%7Corg.kivio%7Cc3faces%7C1.0%7Cjar).

<!--more-->

This version is based on the work of Martin Linha who started the project in 2015 but
do not maintains it any longer. There were several requests which voted for an
official release to Maven central making it easy to declare it as dependency in
an webapps pom.

I forked this library and and refactored some internals preparing the library for
some additions coming with version 1.1 which is planned for February.

Changelog about further changes between the original version and the forked one
can be found in the official [Changelog](https://github.com/rollinhand/c3faces/blob/master/CHANGELOG) 
in the GitHub repository.

A showcase presenting the yet implemented features can be found on 
[http://c3faces.kivio.org](http://c3faces.kivio.org).

Have fund while playing around with C3Faces and if you find any issues or have
suggestions for new features please [leave a comment](https://github.com/rollinhand/c3faces/issues).
