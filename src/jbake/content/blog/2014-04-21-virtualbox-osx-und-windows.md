~~~~~~
type=post
title=Windows mit VirtualBox unter OS X Mavericks virtualisieren
creator=rollinhand
date=2014-04-21
category=Technologie
~~~~~~
Tests unter OS X Mavericks haben gezeigt, dass sich Windows-Systeme unter dem neuen 
Betriebssystem von Apple nicht mit VirtualBox virtualisieren lassen. Details zu meinem 
Test finden sich in diesem Posting.

<!--more-->

Durchsucht man das Internet nach einem Hypervisor zur Virtualisierung eines Rechners 
unter OS X trifft man meist auf die drei Vertreter VMware Fusion, Parallels Desktop 
und Oracle Virtualbox. In vielen Foren und Artikeln wird Virtualbox bevorzugt, da das 
Programm kostenlos ist und stabil läuft.

Leider trifft dies nicht auf alle Anwendungsfälle zu. An dieser Stelle ein Überblick, 
wann Virtualbox der richtige Hypervisor ist.

Im Test kam Virtualbox 4.3.10 mit dem entsprechenden Extension Pack zum Einsatz. 
Die Hardware ist ein MacBook Pro mid 2010 mit 8 GB RAM und OS X 10.9.2 installiert. 
Installiert wurden die folgenden Betriebssysteme:

* Oracle Linux Server 6.5.0 (64-Bit)
* Raspbian Wheezy (32-Bit)
* Windows 7 (32-Bit)

Linux-Systeme lassen sich problemlos unter Virtualbox installieren. Es sollte darauf 
geachtet werden, dass die Kernel Header Sourcen auf dem System verfügbar sind, 
ansonsten können die Virtualbox Additions nicht die entsprechenden Kernel-Module bauen.

Leider funktioniert Virtualbox nur leidlich mit einem virtualisierten Windows-System.

Die Installation geht zügig vonstatten. Allerdings wurde bei der ersten Installation 
eine Kernel panic in OS X erzeugt. Nach einer erneuten Installation von Windows 7 lief 
das System zunächst stabil. Allerdings stürzte es später beim Windows Update ab.

Eine Suche in den Foren von Virtualbox und Apple hat ergeben, dass es scheinbar 
zu [Problemen mit dem Treiber für die Grafikkarte](https://discussions.apple.com/thread/5287447?start=15&amp;tstart=0) 
kommt und dadurch eine Kernel panic erzeugt wird.

**Fazit des Tests:** Für den Einsatz von virtualisierten Windows-Maschinen sollte auf 
VMware Fusion oder Parallels Desktop zurückgegriffen werden. Wer nur unixoide Systeme 
unter Virtualbox unter OS X virtualisieren will, sollte auf jeden Fall einen Blick auf 
Virtualbox werfen.
