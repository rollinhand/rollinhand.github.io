type=post
title=NetBeans 9 vermisst
date=2017-12-31
category=Entwicklung
tags=Java Oracle NetBeans
~~~~~~
Java 9 ist seit geraumer Zeit in der finalen Version verfügbar. NetBeans 9 lässt allerdings nach wie vor noch auf sich
warten. Der Umzug zu Apache ist aufwändiger als gedacht.

<!--more-->

Bislang wurden neue Major-Version von Java und NetBeans fast zeitgleich veröffentlicht, sodass NetBeans immer die erste
IDE war, die neue Sprachfeatures unterstützt hat. Geplant war die Veröffentlichung der Version 9.0 bereits für 
[Juni 2017](http://wiki.netbeans.org/NetBeans_9). Durch die von Oracle initiierte Übergabe von NetBeans an das 
Apache-Projekt konnten diese ambitionierten Ziele nicht eingehalten werden.

## Module müssen überprüft werden
NetBeans besteht aus zahlreichen Modulen, die die gesamte IDE ausmachen. Bevor ein Projekt offiziell unter das Dach der
Apache Foundation schlüpfen kann, ist zu gewährleisten, dass die Software frei von Rechten Dritter ist und das der Code 
den Anforderungen der Apache 2.0-Lizenz entspricht. Das sieht auch vor, dass im Quellcode entsprechende Header-Passagen
eingefügt sind.

Zum aktuellen Zeitpunkt ist die Community rund um NetBeans mehr mit der Apache-Kompatibilität als mit neuen Features
beschäftigt. Damit die Arbeit an der Prüfung der Module schneller voran geht, hat die 
[Community einen Aufruf gestartet](https://cwiki.apache.org/confluence/display/NETBEANS/List+of+Modules+to+Review) und
sucht freiwillige Helfer, die ebenfalls Module auf lizenzrechtliche Gültigkeit prüfen.

Auf der eingerichteten Wiki-Seite kann ebenfalls nachvollzogen werden, wie viele Module und deren Abhängigkeiten noch zu
prüfen sind. Demnach sieht es für ein baldiges Release schlecht aus.

## NetBeans als IDE abgehängt
Während IntelliJ und Eclipse bereits neue Versionen ihrer IDE mit Unterstützung für Sprachfeatures von Java 9 wie dem 
Modulsystem Jigsaw veröffentlicht haben, ist NetBeans immer noch mit sich selbst beschäftigt.

Dabei zeigt sich, dass Oracle aus seiner Transition von OpenOffice zu Apache nichts gelernt hat. Nachdem OpenOffice
heute keine Bedeutung mehr hat - alle wichtigen Linux-Distributionen unterstützen LibreOffice - könnte NetBeans das
gleiche Schicksal drohen.

Meine noch im März geäußerte Euphorie ist aktuell mächtig gedämpft.

