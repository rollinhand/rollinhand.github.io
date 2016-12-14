---
layout: post
title: "Get rid of Maven directory in your WAR"
creator: rollinhand
date: 2016-03-17
category: Development
---
While you are packaging your web application with Maven you might have encountered, 
that your pom.xml and other Maven related files are also packed into your archive. 
To get rid of this directory adopt your pom.xml and configure the maven-war-plugin:

```
<plugin>
  <groupId<org.apache.maven.plugins</groupId>
  <artifactId<maven-war-plugin</artifactId>
  <version<2.2</version>
  <configuration>
    <archive>
      <addMavenDescriptor>false</addMavenDescriptor>
```

With adding `addMavenDescriptor=false` WAR packaging will dismiss the the pom.xml in your archive.
