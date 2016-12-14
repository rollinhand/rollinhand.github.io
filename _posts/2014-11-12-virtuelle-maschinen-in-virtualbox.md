---
layout: post
title: "Virtuelle Maschinen in VirtualBox umziehen"
creator: rollinhand
date: 2014-11-12
category: Technology
---
Virtuelle Maschinen in VirtuialBox auf einen externen Datenträger zu verlagern ist einfach. 
Dieses Post zeigt, welche Schritte zu beachten sind, um die Maschinen auf unterschiedlichen 
Systemen verwenden zu können.
<!--more-->

Sollen Virtual Machine Images in VirtualBox auf unterschiedlichen Hostsystemen genutzt 
werden, so bietet es sich an, die eigentlichen Images auf eine externe Festplatte auszulagern. 
Das dargestellte Szenario und die damit einhergehenden Schritte können auch angwendet werden, 
wenn einfach Festplattenspeicher freigegeben werden soll bzw. die Maschinen ausgelagert werden sollen.

Virtualbox speichert den Lagerort der Virtual Machine Images in einer Konfigurationsdatei, 
die im Verzeichnis des jeweiligen Benutzers liegt:

* __Windows:__ %USERPROFILE%\.VirtualBox\VirtualBox.xml
* __Linux:__ ~/.VirtualBox/VirtualBox.xml
* __Mac:__ ~/Library/VirtualBox/VirtualBox.xml

Damit die Konfigurationsdatei geändert werden kann, sollte VirtualBox nicht laufen 
und alle virtuellen Maschinen gestoppt sein. Danach sind die folgenden Schritte auszuführen, 
die im Einzelnen genauer erläutert werden:

* Alle Virtual Machine Images an den neuen Zielort verschieben.
* Standardspeicherort für die Images auf den neuen Zielort ändern.
* Vorhandene Speicherorte in der Konfigurationsdatei anpassen.
* Überprüfen der Änderung.

Die durchzuführenden Änderungen können an einem praktischen Beispiel nachvollzogen werden.

### Virtual Machine Images verschieben
Wurden die Standardeinstellungen von VirtualBox nicht geändert, so landen alle neuen 
virtuellen Maschinen automatisch in einem vorausgewählten Verzeichnis. 
In diesem Verzeichnis wiederum befindet sich für jede virtuelle Maschine ein eigener Ordner:

* __Windows:__ %USERPROFILE%\VirtualBox VMs
* __Mac/Linux:__ ~/VirtualBox VMs

Das Beispiel bezieht sich auf Windows. Die untergeordneten Verzeichnisse unter VirtualBox 
VMs werden in diesem Beispiel an den neuen Speicherort D:\Virtualbox verschoben. 
Unter Mac/Linux könnte das neue Verzeichnis unter einem beliebigen Mountpunkt liegen.

### Konfigurationsdatei editieren
Während das Betriebssystem die Ordner und die Images an den neuen Zielort verschiebt, 
kann die Konfigurationsdatei mit einem Texteditor bearbeitet werden. Die XML-Datei ist 
klar strukturiert aufgebaut. So befinden sich die Standardeinstellung für den Speicherort 
unter dem Tag SystemProperties. Hier muss das Attribut defaultMachineFolder angepasst 
werden. Das sollte dann in etwa so aussehen:
```
<SystemProperties defaultMachineFolder="D:\Virtualbox" defaultHardDiskFormat="VDI" .../>
```

Für jede virtuelle Maschine gibt es in der MachineRegistry einen eigenen Eintrag mit 
Verweis auf den entsprechenden Ordner. Hier müssen die Pfade auch noch an den neuen 
Zielort angepasst werden. Das kann dann wie folgt aussehen:

```
<MachineRegistry>
<MachineEntry uuid="{947fa526-2336-4f29-be56-492873cecd8d}" src="D:\Virtualbox\Service Delivery Platform\Service Delivery Platform.vbox"/>
<MachineEntry uuid="{c722b767-60d1-4a5c-91e2-8cd0a02b29c2}" src="D:\Virtualbox\Weblogic 12.1.1\Weblogic 12.1.1 (Original Oracle-Image).vbox"/>
...
</MachineRegistry>
```

Nachdem die Konfigurationsdatei gespeichert worden ist, kann mit den Tests weitergemacht werden.

### Testen der Modifikationen
Der einfachste Test - nachdem die Ordner verschoben worden sind - ist, die Oberfläche von 
Virtualbox aufzurufen und eine virtuelle Maschine zu starten. Funktioniert dies nicht mehr, 
ist der Kopiervorgang fehlgeschlagen oder es liegt ein Konfigurationsfehler vor.

Sind die Daten zunächst nur kopiert worden, so sollte der Originalordner umbenannt 
werden und dann mit (1) fortgefahren werden.
