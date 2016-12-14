---
layout: post
title: "Nicht unterbuttern lassen..."
creator: rollinhand
date: 2016-03-08
category: Development
---
Das JSF-Framework ButterFaces ist neu am Markt und will einiges anders machen als die bereits etablierten.
<!--more-->

Eigentlich gibt es schon genügend JSF-Frameworks auf dem Markt. Neben den populären und 
etablierten wie PrimeFaces und OmiFaces haben sich einige kleinere Frameworks (BootsFaces, ICEFaces) 
etabliert. Bedarf es da noch eines weiteren Frameworks?

ButterFaces setzt auf Bootstrap und jQuery auf, um Responsive Web-Design zu unterstützen. 
Im Gegensatz zu anderen Frameworks stellt ButterFaces keinen Wrapper für jede Bootstrap-Komponente 
zur Verfügung. Lediglich bei Komponenten, wo ein JSF-Wrapper sinnvoll ist 
(Visualisierung und Eingabe von Daten), werden entsprechende JSF-Komponenten zur Verfügung gestellt.

Alle anderen Bootstrap-Komponenten wie Jumbotron, Navbar, Flex-Grid und Glyphicons 
können direkt verwendet werden. Nicht nur der JSF-Komponentenbaum wird dadurch weniger 
aufgebläht, sondern auch die in das Projekt einzubindende Bibliothek bleiben klein und 
schlank. Gerade wenn es um die Laufzeit von Anwendungen geht, ein nicht zu unterschätzender Vorteil.

Neben einer guten Dokumentation befindet sich auf der Webseite der beiden 
Entwickler Lars Michaelis und Stephan Zerhusen ein Showcase, der die Funktionalitäten 
der einzelnen JSF-Komponenten und den Einfluss der zu konfigurierenden Attribute 
eindrücklich demonstriert.

Andere Frameworks wie ICEFaces oder PrimeFaces bringen noch Komponenten mit, 
um Charts rendern zu lassen. Auch auf diese Komponenten verzichtet ButterFaces 
und konzentriert sich nur auf das Wichtigste. Wer dennoch Charts in seiner Anwendung 
benötigt, kann ButterFaces mit HighFaces oder HighCharts kombinieren.

### Fazit
Das Framework macht auch in der sehr frühen Version schon einen robusten Eindruck. 
Aufgrund des hervorragenden Showcase ist der Einstieg leicht gemacht. 
In der Dokumentation finden sich ebenfalls Exkurse wie ButterFaces mit Komponenten 
aus BootsFaces oder PrimeFaces genutzt werden können - für all diejenigen, denen der Standard nicht genügt.

Es bleibt spannend in welche Richtung sich dieses Framework noch entwickeln wird...
