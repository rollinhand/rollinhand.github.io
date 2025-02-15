---
layout: post
title: Eclipse RCP - Tipps und Tricks
date: 2020-06-28
category: Entwicklung 
tags: [Eclipse,RCP,Maven,Tycho,Apache Felix]
---
[Lars Vogel][vogella] hat mit seinen [Tutorials zu Eclipse RCP][vogella] eine solide Basis
geschaffen, um mit Eclipse RCP Anwendungen zu entwickeln. Es gibt allerdings trotz der umfangreichen
Beispiele immer wieder Fallstricke, die das Arbeiten mit RCP zu keinem Genuss machen. In diesem
Beitrag zeige ich ein paar immer wieder auftretende Probleme und wie diese gelöst werden können.

<!--more-->

## RCP-Projekte mit Maven und Tycho bauen
Auf Eclipse RCP basierende Projekte lassen sich seit einigen Jahren fast problemlos mit [Tycho][tycho] bauen.
Von der Eclipse Foundation wird der Ansatz mit Maven und Tycho weiter gefördert und gilt inzwischen
als der präferierte Weg, eine RCP-Anwendung zu bauen und zu einem Produkt zu bündeln. Der Weg über
die Plugin Development Environment (PDE) gilt inzwischen als _deprecated_ und sollte bei neuen
Projekten nicht mehr genutzt werden. Die Abkehr von der PDE zeigt sich auch in der Projekthistorie:
so finden Bugfixes und Backports keinen Eingang mehr in die PDE.

Allerdings ist Tycho und insbesondere die Auflösung von Abhängigkeiten noch nicht perfekt und
Fehlermeldungen sind beizeiten kryptisch.

Beispiel gefällig?

### Equinox-Launcher Artefakte für Produkt-Materialisierung einbinden
In der Produkt-Definition für eine RCP-Anwendung kann festgelegt werden, dass beim Build native
Launcher-Artefakte erstellt werden. Das sind die Executables und Windows oder die paketierten
App-Bundles unter Mac OS, die eine Java Laufzeitumgebung mit den notwendigen Artefakten und die
Eclipse Runtime und weitere Plugins starten.

Leider gehören die Artefakte weder zum "E4 RCP Feature" noch zum normalen "RCP Feature". Wird der
Build gestartet, so kommt es bei der Produkt-Materialisierung zu einer [Exception][eclipse1], die
nicht sonderlich aussagekräftig ist.

```bash
[DEBUG] No solution found because the problem is unsatisfiable.: [Unable to satisfy dependency from org.kivio.depot.product 1.0.0.qualifier to org.eclipse.equinox.executable.feature.group 0.0.0.; No solution found because the problem is unsatisfiable.]
[INFO] {osgi.os=win32, osgi.ws=win32, org.eclipse.update.install.features=true, osgi.arch=x86_64}
[ERROR] Cannot resolve project dependencies:
[ERROR] Software being installed: org.kivio.depot.product 1.0.0.qualifier
[ERROR] Missing requirement: org.kivio.depot.product 1.0.0.qualifier requires 'org.eclipse.equinox.executable.feature.group 0.0.0' but it could not be found
```

Hinter dem fehlenden Feature "org.eclipse.equinox.executable.feature.group" verbergen sich die
["Eclipse Platform Launcher Executables"][stackoverflow1]. Jeder RCP-Entwickler sollte dieses Feature also auch in
seine Target Platform integrieren, wenn bei der Produkterstellung native Launcher erstellt werden
sollen. Eine andere Lösung ist, den Haken für native Launcher in der [Produktdefinition zu entfernen][stackoverflow1].

## OSGi-Bundles mit Apache Felix
Mit dem [Apache Maven Bundle][bundle] lassen sich aus eigenem Code oder bestehenden
Drittbibliotheken OSGi-Bundles erstellen, die zusätzliche Informationen zu den nach außen
exponierten Packages sowie der internen Benennung und noch viel mehr enthalten. Entweder kann in der
POM-Datei im Detail angegeben werden, wie die MANIFEST.MF erzeugt werden soll oder es kann eine
feste MANIFEST.MF hinterlegt werden.

### Dynamische MANIFEST.MF in Eclipse korrekt verwenden
Die dynamisch aus der POM erzeugte MANIFEST.MF sollte nach Möglichkeit nicht im _/target_-Ordner
erzeugt werden, da die Plugin-Entwicklung in Eclipse eigenen Gesetzen unterliegt, die historisch
durch die PDE bedingt sind. Normalerweise haben Eclipse-Plugins die folgende Verzeichnisstruktur

```bash
+ my.plugin
+- bin
+- src
+- META-INF
+-- MANIFEST.MF
+- plugin.xml
+- build.properties
```

In der POM sollte über das Attribut `manifestLocation` das Verzeichnis _META-INF_ direkt unterhalb 
des Root-Verzeichnisses des Projekts erzeugt werden.
Für den Build-Prozess über Maven ist das irrelevant, für den [M2E-Connector für das Maven
Bundle (Tycho)][m2e-bundle] nicht. Er interpretiert die Location in der POM-Datei und erzeugt über Alt+F5
das entsprechende Verzeichnis inkl. der zu generierenden MANIFEST.MF.

So lässt sich nicht nur die MANIFEST.MF in einem grafischen Editor analysieren, sondern es ist
auch möglich zwischen Eclipse-Plugins und OSGi-Bundles in Eclipse zu navigieren, indem die
Dependencies angeklickt werden. Bei Projekten mit vielen Plugins und Abhängigkeiten, ein nicht zu
unterschätzendes Feature.

### Neu verpackte Bibliotheken
Code von Dritten, der keine OSGi-Informationen besitzt, kann mit dem Maven Bundle-Plugin neu
verpackt werden, sodass dieser als Plugin bzw. Bundle in einer RCP-Anwendung genutzt werden kann.

Es besteht die Option, den Code _inline_ zu übernehmen. Dabei wird das Original-JAR entpackt und die
enthaltenen Code-Fragmente in ihre Original-Struktur in das neue Paket übernommen. dadurch kann als
Classpath-Angabe in der MANIFEST.MF der Punkt (.) genutzt werden.

Mit dieser Möglichkeit leidet allerdings der Komfort bei der Entwicklung in der Eclipse-Umgebung,
wenn ausschließlich Drittbibliotheken neu paketiert und als Abhängigkeit verwendet werden sollen.

Solange wie die Projekte als Abhängigkeit in der Eclipse geöffnet sind, versucht die IDE zunächst
die Abhängigkeit in den eigenen Projekten aufzulösen. Das wird auch funktionieren. Dabei werden
allerdings keine Sourcen gefunden, da _inline_ durch M2E Tycho nicht interpretiert wird. Abhängige
Projekte zeigen dadurch Kompilierfehler an und werden in der IDE mit einem roten X markiert.

Dieses Vorgehen ist mehr als verwirrend, da das fertig gebaute und transformierte Bundle natürlich
die richtigen Sourcen enthält. Folgende beiden Best Practices bieten sich daher an:

* Soll _inline_ genutzt werden, ist das Projekt zu bauen und in das lokale Maven Repository zu
  installieren. Es sollte nicht zusammen mit dem abhängigen Projekt in der Eclipse IDE geöffnet sein.
* Alternativ können auch die Original JAR-Dateien erhalten und der Classpath in der MANIFEST.MF auf
  die JAR-Datei erweitert werden. Dadurch kann das Projekt neben der Abhängigkeit in der
Eclipse-Umgebung geöffnet bleiben, da Eclipse die Original JAR-Datei in die Abhängigkeiten zieht.

### M2Eclipse-Tycho - Achtung beim Einsatz von Felix Bundle Plugin
Bei dem Einsatz von Tycho zusammen mit Maven übernimmt in der Eclipse IDE der [M2E-Tycho
Connector][m2e-bundle] die Übersetzung der verschiedenen Maven Goals sowohl für Tycho als auch das
Maven Bundle Plugin. So werden Code und MANIFEST-Dateien im Hintergrund erstellt.

Aus einem nicht dokumentierten Grund hat die LATEST-Version aus dem 0.9.0-Zweig des M2E-Connectors
eine Einschränkung auf die Maven Bundle Version bis 3.2.0. Höhere Versionen (aktuell ist 4.2.1)
werden mit dem 0.9.0-Zweig nicht länger unterstützt. Kompiliert die Eclipse IDE im Hintergrund
keinen Code mehr oder erzeugt keine MANIFEST-Datei, so ist der Fehler in der aktuellen Version des
M2E-Connectors zu suchen.

Es kann problemlos eine ältere Version des Connectors ohne Einschränkung über die Update site (statt
dem M2E-Store) installiert werden. Es ist allerdings darauf zu achten, dass über den Update-Site
Mechanismus zunächst die neuere Version des Connectors deinstalliert wird.

[vogella]: https://www.vogella.com
[eclipse1]: https://www.eclipse.org/forums/index.php/t/1082939/
[tycho]: https://www.eclipse.org/tycho/
[stackoverflow1]: https://stackoverflow.com/questions/20235184/building-an-eclipse-plugin-using-maven
[bundle]: https://felix.apache.org/components/bundle-plugin/
[m2e-bundle]: https://github.com/takari/m2e-discovery-catalog
[m2e-tycho]: https://repo1.maven.org/maven2/.m2e/connectors/m2eclipse-tycho/0.9.0/
