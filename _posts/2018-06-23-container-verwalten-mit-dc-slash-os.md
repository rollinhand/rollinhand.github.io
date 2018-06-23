---
layout: post
title: Container verwalten mit DC/OS
date: 2018-06-23
category: DevOps
tags: [DC/OS, Container, Docker, Mesos]
cofinpro: https://medium.com/cofinpro/das-eigene-datacenter-in-eine-cloud-verwandeln-7d1e98940889
---
Die Themen Cloud und Container stammen nicht aus Wolkenkuckucksheim,
sondern beschäftigen in der Realität die IT-Abteilungen großer und
kleiner Unternehmen. Hinter diesen Ideen steckt der Wunsch,
Hardware-Ressourcen effizienter auszulasten, Spitzenlasten abzufangen
und Anwendungen bzw. Services beliebig skalieren zu können. Hierbei
können Plattformen wie DC/OS helfen.

<!--more-->

<!--![Photo by [Erwan Hesry](https://unsplash.com/photos/RJjY5Hpnifk?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)
on [Unsplash](https://unsplash.com/search/photos/container?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)]
(https://cdn-images-1.medium.com/max/1000/1*VZf19QtcEYsMaA912V0pkQ.jpeg)-->

### Container --- die Logistikbranche macht es vor 

Bereits 1956 wurden die ersten Frachtcontainer entwickelt. Das typische
Umladen einzelner Gebinde in den Frachthäfen sollte durch die Container
optimiert werden. Die
[ISO-Container](https://de.wikipedia.org/wiki/ISO-Container) wie wir sie heute kennen, haben sich allerdings erst
ab 1966 durchgesetzt. Ihr großer Vorteil ist, dass sie dank der
Normierung über Land und Wasser transportiert werden können, ohne ein
einziges Mal entladen werden zu müssen.

Übertragen auf die IT sind Container ein Deploymentformat für
Anwendungen. Ähnlich wie in der Logistik gibt es auch hier Bemühungen,
ein einheitliches Format zu schaffen: den OCI-Container. Führende
Unternehmen und Cloud-Betreiber wie Google, Amazon und RedHat haben sich
zur [Open Container
Initiative](https://www.opencontainers.org/) zusamengeschlossen und treiben das Format voran, das
aus Docker hervorgegangen ist.

### Container brauchen Infrastruktur 

Was würde der Logistikbranche ein Frachtcontainer bringen, wenn die
Frachträume der Containerschiffe falsch dimensioniert wären, es keine
einheitlichen Kräne gäbe, und die Lastkraftwagen zu kleine Auflieger
hätten? Container schaffen eine Abstraktionsschicht, aber die
eigentliche Arbeit verrichtet die Infrastruktur.

Bis zu einer bestimmten Grenze lassen sich auch Docker-Container ohne
besondere Werkzeuge betreiben. Was aber, wenn die Systemlandschaft aus
Containern nicht klein und überschaubar bleibt? Steigen die
Anforderungen an ein verteiltes System, gewinnt auch der Betrieb schnell
an Stellenwert. Dann muss die Infrastruktur bzgl. Kapazität, Performance
und Verfügbarkeit skaliert werden.

Sofern die Anwendung nicht in einer Public Cloud wie AWS, Azure, oder
OpenShift betrieben wird, wäre ein Cluster-Betriebssystem wünschenswert,
das den IT-Betrieb bei dieser Herausforderung unterstützt.

### DC/OS als Cloud-Betriebssystem 

[DC/OS](https://mesosphere.com/product/) ist eine Integrationsplattform für den Betrieb von
containerisierten Anwendungen und Services. Das "DC" für "Distributed
Computing" weist schon auf das Ziel hin, eine verteilte Umgebung über
viele Server und Standorte zu schaffen --- egal ob Public-Cloud oder
eigenes Rechenzentrum.

![DC/OS Architektur
([Quelle](https://docs.mesosphere.com/1.11/overview/architecture/))](https://cdn-images-1.medium.com/max/800/1*kUZ08-I1nEITGfCihng6Pw.png)

Der Unterbau für DC/OS ist [Apache
Mesos](http://mesos.apache.org/): ein
verteilter System-Kernel, der sich ähnlich wie der Linux-Kernel um die
Verwaltung von CPUs, Speicher und Prozessen kümmert --- nur eben nicht
auf einer Maschine, sondern verteilt. Mesos kann von Haus aus mit
Containerformaten umgehen, und über eine HTTP-API, oder ein (nicht ganz
so schickes) Frontend gesteuert werden.

### DC/OS ist mehr als Apache Mesos 

Die Entwickler von DC/OS Mesosphere haben das Frontend von Mesos durch
eine eigene Weboberfläche ersetzt, die in der aktuellen Version 1.11
keine Wünsche offen lässt. Hiermit lassen sich bereits vorgefertigte
Pakete aus einem Repository installieren, was ähnlich einfach
funktioniert, wie eine App aus einem App-Store zu installieren. Während
der Installation kann der Administrator angeben, auf wie vielen
Instanzen der Service installiert werden soll.

DC/OS entscheidet selbst anhand verschiedener Kriterien auf welchen
Knoten der Service in welcher Anzahl deployt wird. Hierfür zeichnet sich
die Anwendung
[Marathon](https://mesosphere.github.io/marathon/) verantwortlich, die neben dem Deployment von Services
und Anwendungen auch die Hochverfügbarkeit steuert.

![Marathon
in Aktion](https://cdn-images-1.medium.com/max/800/1*D__DumFiPARcUKt36hfN2Q.png)

Neben Services aus dem Repository kann Marathon auch Docker-Images aus
Container-Registries deployen. Hier ist Docker-Hub bereits angebunden,
der Betrieb einer eigenen Docker-Registry ist ebenso möglich.

### DC/OS im eigenen Rechenzentrum oder der Cloud 

[Einige große
Internetplattformen](https://en.wikipedia.org/wiki/Apache_Mesos#Users) wie [Twitter, Airbnb, eBay oder
Apple](http://mesos.apache.org/documentation/latest/powered-by-mesos/) nutzen Apache Mesos, um ihre Infrastruktur und
Anwendungen zu verwalten. Wem dieser Weg zu aufwändig ist, für den hat
Mesosphere mit DC/OS eine Plattform entwickelt, die den Einsatz im
eigenen Rechenzentrum, oder der Public Cloud einfach macht. Neben Amazon
bieten auch
[Microsoft](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/mesosphere.enterprise-dcos?tab=Overview) und Oracle Unterstützung für DC/OS in ihren
Cloud-Lösungen an.

Einen schnellen Einstieg bietet z.B. Amazon mit der Möglichkeit, einen
[DC/OS Cluster in AWS
aufzusetzen](https://aws.amazon.com/de/blogs/apn/announcing-mesosphere-dcos-on-aws/). Das ist chic, hat allerdings auch seinen Preis
(€€€). Wer lieber kleiner anfangen möchte, für den gibt es auch Skripte
zum Aufsetzen eines
[Clusters](https://github.com/dcos/dcos-vagrant) mit Vagrant.

Mesosphere Inc. stellt kommerziellen Support für Apache Mesos und das
zugrunde liegende Öko-System bereit. Die freie Variante von DC/OS fast
wichtigen Funktionen, lediglich die erweiterte Rechteverwaltung und
Multi-Cloud-Unterstützung für noch höhere Verfügbarkeit sind der
kommerziellen Enterprise-Version vorbehalten.

### Fazit 

Vergleicht man eine Container-basierte Systemlandschaft mit großen
Hafenterminals wie Hamburg oder Rotterdam, wird klar, dass sich eine
große Menge von Containern nicht mehr ausschließlich manuell steuern
lässt.

Lagerplätze für Container sind nur noch Koordinaten auf einem
überdimensionalen Schachbrett. Der Disponent entscheidet, wann, wie
viele und in welcher Reihenfolge Container abgelegt werden. Diese Rolle
übernimmt im Rechenzentrum DC/OS: es kümmert um eine bestmögliche
Nutzung aller Ressourcen der Systeme.

