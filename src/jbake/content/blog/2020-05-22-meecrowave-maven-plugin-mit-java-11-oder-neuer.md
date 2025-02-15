~~~~~~
type=post
title=Meecrowave Maven Plugin mit Java 11 oder neuer
date=2020-05-22
category=Entwicklung
tags=[Meecrowave,Java11]
~~~~~~
Das Meecrowave Maven Plugin sorgt nicht nur für die korrekte Bündelung der eigenen Anwendung in den
Meecrowave Container sondern kann auch während der Entwicklung genutzt werden, um den Server zu
starten und Debugging-Aktionen durchzuführen. Mit Java 11 und neuer kann das schief laufen. In dem
Beitrag zeige ich, wie das Plugin weiterhin voll funktionsfähig bleibt.

<!--more-->

Wer das Meecrowave Maven Plugin in einer älteren Version zusammen mit Java 11 oder neuer nutzt, stößt bei der Ausführung des
Kommandos `mvn meecrowave:run` schnell auf die Fehlermeldung:

```bash
Caused by=java.lang.ClassNotFoundException=javax.xml.bind.JAXBException
```

Seit Java 11 sind die _javax_-Pakete aus der Java VM entfernt worden, sodass auch der Schalter
`--add-modules ALL_SYSTEM` keine Wirkung mehr zeigt. Es gehörte mit der Einführung von Jigsaw in
Java 9 bereits zum schlechten Stil, auf diesem Weg auf der Streichliste stehende Module zu
aktivieren.

Um das Meecrowave Maven Plugin trotzdem zum Laufen zu bekommen, genügt es, dem Plugin eine
zusätzliche Abhängigkeit mitzugeben:

```xml
<plugin>
  <groupId>org.apache.meecrowave</groupId>
  <artifactId>meecrowave-maven-plugin</artifactId>
  <version>1.2.9</version>
  <dependencies>
    <dependency>
      <groupId>javax.xml.bind</groupId>
      <artifactId>jaxb-api</artifactId>
      <version>2.3.1</version>
    </dependency>
  </dependencies>
</plugin>
```

Anschließend kann das Plugin wieder wie gewohnt benutzt werden.

Und wer diese Verrenkung nicht vornehmen möchte, der wechselt auf die aktuellste Version von
Meecrowave derzeit in der Version 1.2.9. Ab der Version 1.2.6 tritt der Fehler im Maven Plugin nicht
mehr auf.
