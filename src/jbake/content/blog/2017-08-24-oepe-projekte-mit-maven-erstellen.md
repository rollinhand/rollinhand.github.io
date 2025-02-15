---
layout: post
title: "OEPE: Projekte mit Maven erstellen"
date: 2017-08-24
category: Entwicklung
tags: ["ADF", "Oracle", "Java"]
---
ADF-Projekte werden nach den Oracle-Tutorials nicht unbedingt mit einem allgemeinen Build-Tool
wie Maven erstellt. In Oracles Enterprise Pack for Eclipse (OEPE) verstecken sich allerdings auch
Maven-Archetypen, um ein typisches ADF-Projekt zu erstellen.

<!--more-->

Oracle liefert in OEPE einen Maven archetype mit, um eine ADF Basic Application erstellen zu
können. Dieses auf Basis von Maven erstellte Projekt lässt sich dann problemlos in Eclipse (OEPE)
importieren.

Der Archetyp befindet sich im Installationsverzeichnis von oepe unter 
`plugins\oracle.eclipse.tools.adf_7.4.0.201504081335\maven\ADF Basic Application Archetype`

### Archetype installieren
Auf der Kommandozeile werden in diesem Verzeichnis nacheinander die folgenden Kommandos
ausgeführt, um den Archetypen in das lokale Maven-Repository zu integrieren:

```
mvn clean install
mvn archetype:update-local-catalog
```

### Projekt initial erstellen
Um ein initiales Projekt mit diesem Archetypen anzulegen, kann der folgende Befehl auf der
Kommandozeile abgesetzt werden:

```bash
mvn archetype:generate -DarchetypeGroupId=com.oracle.adf.archetype -DarchetypeArtifactId=adf-basic-application -DarchetypeVersion=12.1.2-0-0
```

### Besserer OEPE Archetype
Da es immer wieder Probleme mit dem mitgelieferten Archetypen von Oracle gegeben hat, weil
die Templates nicht korrekt waren oder Abhängigkeiten nicht mit der verwendeten OEPE- bzw.
ADF-Version überein stimmten, habe ich einen eigenen Archetype erzeugt, der ein sofort
funktionales ADF Projekt erzeugt. 

Das Projekt findet sich auf [GitHub](https://github.com/rollinhand/oepe).

