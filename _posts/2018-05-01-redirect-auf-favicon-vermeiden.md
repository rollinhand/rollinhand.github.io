---
layout: post
title: Redirect auf Favicon vermeiden
date: 2018-05-01
category: Entwicklung
tags: [JSF, Java] 
---
Bei einer mit Apache Shiro (oder ein anderem Framework) abgesicherten JSF-Seite wird
der Anwender nach dem Login zunächst immer auf die Datei _favicon.ico_ weitergeleitet.
Ursachen und deren Behebung habe ich in diesem Blog-Beitrag zusammengetragen.

<!--more-->

Das oben beschriebene Problem tritt mit allen modernen Browsern auf. Vom Internet
Explorer über Google Chrome bis hin zu Apples Safari. Hierfür können verschiedene
Ursachen der Grund sein. Jeder der Browser sucht auf einer Webseite nach dem 
Favicon, dass sowohl in der URL-Zeile als auch beim Setzen eines Lesezeichens
herangezogen wird.

Warum aber wird der Anwender nun ausgerechnet nach dem Login auf _favicon.ico_
weitergeleitet statt auf die eigentliche Seite im Redirect?

## Kein Favicon hinterlegt
Jede moderne Webseite sollte ein Favicon hinterlegt haben. Der Standard-Dateiname
für das Icon ist _favicon.ico_ und der Browser sucht nach diesem Icon im Root-
Verzeichnis der Web-Anwendung, wenn innerhalb der Seite kein anderes Ziel für
das Icon hinterlegt ist (siehe nächsten Punkt).

Nach dem Login versucht der Browser beim Redirect das Icon mittels HTTP GET zu laden
und scheitert daran. Diesen Versuch bekommt der Anwender direkt mit.

## Verweis auf Favicon ist falsch
Innerhalb der Webseite kann über 

```
<link rel="shortcut icon" href="/pics/favicon.ico"> 
```

ein Verweis auf den Speicherort des Icons angegeben werden. Häufig wird das Icon
allerdings nicht mehr als 16-Bit ICO-Datei hinterlegt, sondern als PNG oder JPG,
da moderne Browser keine Einschränkung mehr bei der Farbtiefe für die Bilder besitzen
und auch PNG bspw. Transparenz unterstützt.

Das bedeutet, dass in diesem Link auch der korrekte Dateiverweis hinterlegt sein sollte.
Zusätzlich kann der Browser noch unterstützt werden, indem die Art der Bilddatei
über das `type`-Attribut mitgeteilt wird:

```
<link rel="shortcut icon" href="/pics/favicon.png" type="image/png">
```

## Ressource liegt im geschützten Bereich
Ist die Web-Anwendung mit Apache Shiro oder einem anderen Security-Framework abgesichert,
so sollte das Favicon, wie auch bspw. CSS-Dateien im ungeschützten Bereich liegen.

In Apache-Shiro kann dies für eine JSF-Anwendung über die _shiro.ini_ erreicht werden:

```
/javax.faces.resource/** = anon
```

Damit sind alle JSF-Ressourcen wie Bilder, CSS, etc. nicht mehr geschützt.


Anhand dieser drei möglichen Ursachen sollte sich das fehlerhafte Routing auch in euren
Web-Anwendungen schnell abstellen lassen.
