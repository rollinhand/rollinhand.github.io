---
layout: post
title: Hibernate&#58; Hilfe, mein Class-Mapping funktioniert nicht mehr
date: 2020-06-04
category: Entwicklung 
tags: [Hibernate]
---
Zuletzt war ich in einem Projekt beschäftigt, dass für seine Persistenz noch auf Hibernate 3.2.0 und
Mapping-Dateien (hbm-Dateien) im XML-Format gesetzt hat aus dem sich auch persistente Klassen
generieren lassen. Mit dem zunächst sanften Upgrade auf Hibernate 3.6.10 konnten persistente Klassen
nicht mehr über die Klasse `Configuration` gefunden werden. Oups! Was war zu tun?

<!--more-->

In vielen Legacy-Projekten mit Hibernate gibt es die berühmt berüchtigte Klasse HibernateUtil, die
bspw. genutzt wird die Konfiguration einzulesen, die SessionFactory zur Verfügung zu stellen und
sonstige Funktionalitäten, die von einer Utility-Klasse erwartet werden.

Unter anderem auch die Möglichkeit, dass aus dem kanonischen Namen einer Klasse die
Mapping-Informationen aufgelöst werden können:

```java
Configuration cfg = Configuration.configure();
String className = "org.kivio.depot.Aktie";
PersistentClass cls  = cfg.getClassMapping(className); 
Table tbl = cls.getTable();
```

Seit Hibernate 3.6 liefert `cfg.getClassMapping` einen Null-Wert zurück und beim Debuggen stellt
sich heraus, dass die zugrunde liegende Map in der Klasse `Configuration` keine Werte enthält. Das
bedeutet, dass beim Erzeugen der `Configuration` die Mappings nicht mehr erzeugt bzw. übersetzt
werden.

Damit dies auch mit neueren Versionen von Hibernate funktioniert, sind die Mappings explizit zu
erzeugen. Die Übersetzung aus den Mapping-XML-Dateien benötigt einen Moment und da der Trend zu
Annotationen-basierter Programmierung geht, wurde diese für die Initialisierung aufwändige
Funktionalität aus dem automatischen Prozess entfernt.

Damit die Mappings auch weiterhin über `getClassMapping` abgerufen werden können, ist die obige
Code-Passage um die Anweisung `cfg.buildMappings()` zu ergänzen.

```java
Configuration cfg = Configuration.configure();
cfg.buildMappings();    // call explicit
String className = "org.kivio.depot.Aktie";
PersistentClass cls  = cfg.getClassMapping(className); 
Table tbl = cls.getTable();
```

Dadurch verlängert sich die Initialisierung und die Erstellung der Konfiguration, im Anschluss
stehen die Mapping-Informationen allerdings wieder programmatisch zur Verfügung.


