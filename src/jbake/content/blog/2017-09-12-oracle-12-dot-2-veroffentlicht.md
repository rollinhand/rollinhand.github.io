~~~~~~
type=post
title=Oracle 12.2 veröffentlicht
date=2017-09-12
category=Technologie
tags=["Oracle", "Datenbank"]
~~~~~~
Nachdem die Oracle-Datenbank in der Version 12.2 bis vor Kurzem nur in Oracles Cloud Services verfügbar war, ist die aktuelle Version der Datenbank nun für alle zum [Download](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html) verfügbar. Der Artikel beschreibt in Kürze die neuen Features.

<!--more-->

## Multitenant-Architektur
Mit der Version 12.2 setzt Oracle nun vollständig auf die **Multitenant-Architektur** und setzt damit voll auf den Trend Software in der Cloud zu betreiben. Mit den Pluggable Databases (PDB) soll es möglich sein, Ressourcen und damit Kosten einzusparen.

Das Prinzip sieht vor, dass sich mehrere PDB innerhalb einer Container-Datenbank (CDB) gemeinsame Ressourcen teilen. War bisher nur vorgesehen, dass sich PDBs den Hauptspeicher teilen, ist der Schritt in Version 12.2 weiter gedacht und es besteht die Möglichkeit, dass sich PDBs auch das gleiche Datenmodell und sogar statische Anwendungsdaten teilen können.

Operationen wie das Verschieben und Klonen von Datenbanken (PDB) sind nun online möglich. Damit allerdings das Verschieben von Datenbanken (Relocate) fast vollständig ohne Downtime funktioniert, sind eine Menge Besonderheiten beim Aufsetzen der jeweiligen Container-Datenbank zu berücksichtigen. Ohne eine kurze Downtime, wie beim Verschieben von virtuellen Maschinen in VMWares VSphere, ist die Relocation allerdings nicht möglich.

## Adaptive Features
Die adaptiven Features in Oracle 12.2 wurden verbessert - man könnte auch sagen, die adaptiven Features sollen nun endlich wie gewünscht funktionieren. Vielfach haben frustrierte Datenbankadministratoren in der Community berichtet, dass sie die adaptiven Feature deaktiviert haben, da nicht nachvollziehbar war, wie der Optimizer beeinflusst wurde.

Die ersten Erfahrungsberichte der Oracle 12.2-Datenbank bleiben abzuwarten.

## Neue Features für Entwickler
Bisher lästig war die **Zeichenbeschränkung** von 30 Bytes für Bezeichner. Diese Grenze wurde nun auf 128 Bytes angehoben, sodass auch aussagekräfte Namen vergeben werden können. Auch wird die Migration zum Beispiel von PostgreSQL-Datenbanken zu Oracle damit einfacher.

Bereits besonders ausgereift war das Zugreifen auf abgelegte XML-Daten; mit 12.1 kam die Möglichkeit hinzu auch **JSON-Daten** abzulegen und mittels Abfragen auf die Daten zuzugreifen. Richtig rund und ausgereift waren die zur Verfügung gestellten Funktionen allerdings noch nicht. Hier wurde neue und verbesserte Funktionen zur Verfügung gestellt.

*Ausführliche Details zu Oracle 12.2 finden sich in der Ausgabe 4/2017 des Red Stack Magazins der DOAG*
