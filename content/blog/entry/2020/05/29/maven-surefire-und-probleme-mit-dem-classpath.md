type=post
title=Maven Surefire und Probleme mit dem Classpath
date=2020-05-29
category=Entwicklung
tags=Maven,Eclipse
~~~~~~
In meinem letzten Projekt beim Kunden bin ich auf ein interessantes Problem im Maven Surefire Plugin
gestoßen. Während meine Unit-Tests in der Eclipse-Umgebung problemlos liefen, warf Maven auf der
Kommandozeile beim Aufruf von `Class.forName()` eine ClassNotFoundException. Was war da los?

<!--more-->

## Der zu testende Code
Die zu testende Code-Passage, die mit Maven Surefire und Junit 4.12 auf der Kommandozeile immer
wieder fehlegschlagen ist, sah in etwa so aus:


```java
final String className = "org.kivio.depot.Isin"
Class<?> clazz = (Class<?>)Class.forName(className);
```

An dieser Stelle zunächst nichts besonderes. Die Klasse `Isin` befindet sich allerdings in einem als
Dependency deklarierten Jar-File, dass für den Test benötigt wird.

## Die Besonderheit von Maven Surefire
Seit [Maven Surefire 2.8.2](surefire) ist die Behandlung des Classpath und somit auch die
Testausführung geändert worden. Standardmäßig ist der System Class Loader aktiv und Maven Surefire
startet alle Tests mit einem Manifest-Only JAR.

Hierbei wird ein temporäres JAR erzeugt, dass nur den Inhalt `META-INF/MANIFEST.MF` enthält. In dem
MANIFEST sind über das Attribut *Class_Path* alle notwendigen Abhängigkeiten für die Testausführung
mit ihren absoluten Pfaden gesetzt.

Und hier kommen wir zum eigentlichen Problem=System Class Loader, Thread Context Class Loader und
der Default Class Loader sind identisch und verweisen auf das Maven Surefire Booter JAR, das
wiederum Einträge zu den JAR-Dateien mit Klassen enthält, die in einem anderen Kontext geladen
worden sind.

Wenn eine Anwendung ihren Class Loader selbst nach JAR-Dateien oder Klassen befragt, ist es besser,
wenn ein isolierter Class Loader genutzt wird, der alle Abhängigkeiten kennt. Das wäre in diesem
Fall der korrekte Weg, um den Test zu starten und auf den System Class Loader zu setzen. Dies kann
aber gerade im Embedded Kontext - also wenn Maven in einer IDE gestartet wird - wiederum zu anderen
Problemen führen.

Ein weiterer Grund doch eher auf den Manifest-Only-Ansatz zu setzen, ist die Möglichkeit, dass
Surefire Tests parallel ausführen kann und daher Forks vom Hauptprozess erstellt. Beim Forken
scheinen allerdings die Class Loader durcheinander zu kommen und die Wiederverwendung eines Forks
durch Surefire sollte unterbunden werden. Und mit exakt diesem Ansatz kann das Class Loading-Problem
umgangen werden.

## Ein Parameter bringt die Rettung
Eine einfache Änderung der Konfiguration des Surefire-Plugins sorgt dafür, dass
`Class.forName`-Anweisungen im zu testenden Code funktionieren:

```xml
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-surefire-plugin</artifactId>
  <configuration>
    <reuseForks>false</reuseForks>
  </configuration>
</plugin>
```

Mit `reuseForks` kann gesteuert werden, ob Surefire einen geforkten Prozess für einen weiteren Unit
Test wiederverwenden soll. Durch die Unterbindung wird für jeden Testfall ein neuer Prozess
gestartet und der Classpath korrekt gesetzt.

Allerdings hat dieses Vorgehen auch einen gravierenden Nachteil, der nicht verschwiegen werden
sollte=Bei vielen durchzuführenden Tests kommt die Garbage Collection ggf. nicht nach und es kommt
zu einem Überschreiten des GC Overhead Limits.

Die Option sollte also mit Vorsicht gesetzt werden.