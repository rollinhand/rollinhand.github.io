~~~~~~
type=post
title=Wenn der JDeveloper 12c richtig klemmt...
creator=rollinhand
date=2014-10-08
category=Entwicklung
~~~~~~
Oracles JDeveloper ist kein Performance-Wunder. Neben Performanceengpässen hilft manchmal 
nur das "Abschießen" aller zum JDeveloper gehörigen Prozesse, um weiterarbeiten zu können. 
Abhilfe ist da...

<!--more-->

### Beim Debugging einer ADF-Anwendung
Beim Starten des Debuggers in einer ADF-Anwendung startet der Debugger und ggf. wird noch 
die Einstiegsseite für das Debugging geladen. Danach ist allerdings Feierabend. 
Der JDeveloper reagiert auf keine Eingaben mehr und im Task-Manager bzw. der 
Aktivitätsanzeige ist zu sehen, wie die Speicherauslastung kontinuierlich ansteigt.

Dieses Verhalten ist sowohl unter Windows als auch OS X zu beobachten.

Grund für diesen "Freeze" ist das Fenster **ADF Structure**, das in der Debug-Ansicht 
mit geöffnet wird. Es bietet sich an, während des Startens diesen View zu schließen 
und sobald die Debug-Session vollständig geöffnet ist, kann der View wieder über das 
Menü **Window > Debugger > ADF Structure** geöffnet werden.


### Auf einem MacBook Retina
Will man eine JSF-Seite im im grafischen Editor im JDeveloper bearbeiten, so erscheint 
unter OS X auf einem MacBook Pro mit Retina-Display dauerhaft die Meldung `Waiting for Designer to initialize...`. 

Auch mit viel Geduld hat ein Entwickler keine Chance. Der Designer erscheint nicht.

Zugegeben, die Lösung zeigt, dass das Problem nicht der JDeveloper ist, sondern neuere 
Java Versionen unter OS X, die die Retina-Displays unterstützen. 
Erstmalig bietet Java SE 7 u40 Retina-Unterstützung. Alle Versionen größer bzw. 
gleich u40 sorgen für den nicht startenden Designer im JDeveloper.

Die letzte funktionsfähige Version ist das Release u25. Die Version sollte auf den 
Download-Seiten von Oracle heruntergeladen und installiert werden.

Nach der Installation muss die **jdev.conf** im Verzeichnis **JDEV_HOME/jdeveloper/jdev/bin/** angepasst werden.

Die Einstellung **SetJavaHome** sollte auf das neu installierte JDK 7 u25 verweisen:
```
SetJavaHome /Library/Java/JavaVirtualMachines/jdk1.7.0_21.jdk/Contents/Home
```

Danach funktioniert der JDeveloper wieder wie gewohnt. Allerdings müssen Abstriche bei 
der Ansicht gemacht werden. Auf einem hochauflösenden Display sieht die Anwendung 
ziemlich verwaschen aus.

Der Bug im JDK scheint auch in neueren Versionen nicht gelöst zu sein. Auch mit dem u65 
startet der Designer nicht. Das JDK 8 ist auch keine Lösung, denn damit startet der JDeveloper überhaupt nicht.

Das von Apple weiterhin unterstützte JDK 6 hat die Retina-Optimierung fehlerfrei implementiert, 
kann aber nicht mit dem JDeveloper 12c verwendet werden.
