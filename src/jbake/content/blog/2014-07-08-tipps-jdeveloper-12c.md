~~~~~~
type=post
title=Tipps für den Einsatz des JDeveloper 12c
creator=rollinhand
date=2014-07-08
category=Entwicklung
~~~~~~
Die Maven-Unterstützung im JDeveloper 12.1.2 ist wenig gelungen. Wer auf die Version 
festgelegt ist, findet in diesem Post Wege, um die Maven-Unterstützung trotzdem in 
vollem Umfang nutzen zu können.

<!--more-->

Mit dem JDeveloper 12c hat Oracle die lang ersehnte Maven-Unterstützung integriert. 
In der Version 12.1.2 ist die Unterstützung allerdings fehleranfällig und es bedarf 
einiger manueller Eingriffe, um Maven plattformübergreifend und auf verschiedenen 
Entwicklungssystemen nutzen zu können. In diesem kleinen Beitrag werden die notwendigen 
Maßnahmen aufgezeigt, die für einen erfolgreichen und problemlosen Einsatz notwendig sind.

## Oracle Synchronisation durchführen
Damit Maven als Build-Tool genutzt werden kann, müssen die Build-Werkzeuge `ojmake` und `ojdeploy`, 
sowie die für eine ADF-Anwendung notwendigen Bibliotheken im lokalen Maven-Repository oder 
einem Repository-Proxy (wie Archiva, Artifactory oder Nexus) bekannt gemacht werden.

In [1] beschreibt Oracle sehr ausführlich, wie die Synchronisation der Tools und Plugins 
mit einem Maven-Repository durchgeführt werden kann. Allerdings ist die Anleitung 
für die Version 12.1.2 des JDevloper fehlerhaft. Die korrekten Befehle sind im folgenden dargestellt:

JDeveloper ist unter Windows in den Standard-Pfad installiert worden. 
Das Synchronisations-Plugin befindet sich im Pfad *oracle_common\plugins\maven\com\oracle\maven\oracle-maven-sync\12.1.2*

```
mvn install:install-file -DpomFile=oracle-maven-sync.12.1.2.pom -Dfile=oracle-maven-sync.12.1.2.jar
```

Mit diesem Befehl wird das Maven Synchronisationsplugin von Oracle in das lokale Repository 
geladen und kann mit dem Befehl ausgeführt werden:

```
mvn com.oracle.maven:oracle-maven-sync:push -Doracle-maven-sync.oracleHome=C:\Oracle\Middleware\Oracle_Home
```
  
Hierbei ist darauf zu achten, dass die Umgebungsvariable entgegen der Anleitung **oracle-maven-sync.oracleHome** 
lauten muss. Mit dem JDeveloper in der im Juni 2014 erschienen Version 12.1.3 ist dieser Fehler 
behoben. Eine Anleitung zur korrekten Synchronisation der Tools befindet sich unter [2]. 
Edwin Biemond beschreibt in seinem Blog auch die Synchronisation der Plugins mit dem Artefakt Repository Nexus.

## Relative Pfade einführen
In der Version 12.1.2 werden in den POM für Maven grundsätzlich absolute Pfade genutzt. 
Für unterschiedlich installierte Entwicklermaschinen oder eine plattformübergreifende 
Entwicklung ist dieser Ansatz nicht zielführend. Aus diesem Grund müssen bestimmte Pfade 
in den POM-Dateien relativiert werden. [3] beschreibt diese Problematik ausführlich. Eine 
erzeugte POM sieht beispielsweise wie folgt aus:

```
<plugin>
  <groupId>com.oracle.adf.plugin</groupId>
  <artifactId>ojmake</artifactId>
  <version>12.1.2-0-0</version>
  <configuration>
    <ojmake>
      C:\Oracle\Middleware\Oracle_Home\jdeveloper\jdev\bin\ojmake.exe
    </ojmake>
    <files>
      C:\build\FogDash\FogDash.jws
    </files>
    <usemaven>
      true
    </usemaven>
  </configuration>
  <executions>
    <execution>
      <phase>compile</phase>
      <goals>
        <goal>compile</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```

Es ist aus dem Auszug der POM ersichtlich, dass die absoluten Pfade zu Komplikationen 
führen werden. Maven unterstützt für diesen Fall Variablen, sodass die Pfade in der 
POM relativ gesetzt werden können. Dabei können Umgebungsvariablen oder auch spezifische 
Maven-Variablen genutzt werden. Letztere lassen sich über die globalen Maven-Settings oder 
User-Settings (settings.xml) vordefinieren.

Variablen in Maven folgen einem bestimmten Schema:
```
${variable_name}
```

Maven kennt bereits einige vordefinierte Variablen wie *${basedir}*. 
Diese Variable verweist auf das Verzeichnis in der sich die gerade verwendete POM befindet. 
Zusätzlich zu den vordefinierten Variablen kann Maven auf Umgebungsvariablen des Systems 
zugreifen. Dies erfolgt über die Synatx:
```
${env.variable_name}
```
Mit diesen Mechanismen besteht also die Möglichkeit, die Pfade für den Maven-Build zu 
relativieren.

Für die Build-Tools von Oracle kann vergleichbar bei Oracle-Datenbanken unter 
Linux (ORACLEHOME) eine Umgebungsvariable namens **OJ_HOME** erstellt werden, 
die auf den Pfad *C:\Oracle\Middleware\Oracle_Home\jdeveloper\jdev\bin* verweist. 
Auf diese Variable kann in der pom.xml über* ${env.OJ_HOME}* zugegriffen werden. 
Damit die Projektdatei FogDash.jws ebenfalls relativ zu den anderen Pfaden steht, 
wird die Variable *${basedir}* genutzt.

Es besteht die Möglichkeit auch **OJ_HOME** als Maven-Variable zu definieren, 
sodass diese dynamisch bei einem Build gesetzt werden kann. Über die settings.xml 
eines Benutzers könnten sich die Einstellungen somit auch versionieren lassen.

Die angepasste pom.xml (Auszug) sieht nach den Änderungen wie folgt aus:
```
<plugin>
  <groupId>com.oracle.adf.plugin</groupId>
  <artifactId>ojmake</artifactId>
  <version>12.1.2-0-0</version>
  <configuration>
    <ojmake>
      ${env.OJ_HOME}\ojmake.exe
    </ojmake>
    <files>
      ${basedir}\FogDash.jws
    </files>
    <usemaven>
      true
    </usemaven>
  </configuration>
  <executions>
    <execution>
      <phase>compile</phase>
      <goals>
        <goal>compile</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```

Mit dem JDeveloper 12.1.3 ist dieser Fehler ebenfalls gelöst [4]. 
Allerdings werden POM von einem mit JDeveloper 12.1.2 erstellen Projekt 
beim Speichern nicht automatisch angepasst, so dass manuelle Korrekturen unumgänglich sind.


### Quellen:
[1] [http://docs.oracle.com/middleware/1212/core/MAVEN/config_maven.htm#MAVEN8853](http://docs.oracle.com/middleware/1212/core/MAVEN/config_maven.htm#MAVEN8853)

[2] [http://biemond.blogspot.de/2014/06/maven-support-for-1213-service-bus-soa.html](http://biemond.blogspot.de/2014/06/maven-support-for-1213-service-bus-soa.html)

[3] [https://blogs.oracle.com/blueberry/entry/jdeveloper_12c_using_relative_paths](https://blogs.oracle.com/blueberry/entry/jdeveloper_12c_using_relative_paths)

[4] [http://www.oracle.com/technetwork/developer-tools/jdev/documentation/1213nf-2222743.html](http://www.oracle.com/technetwork/developer-tools/jdev/documentation/1213nf-2222743.html)
