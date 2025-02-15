type=post
title=Apache NetBeans 10.0 veröffentlicht 
date=2018-12-30
category=Entwicklung
tags=Java, Apache, NetBeans
~~~~~~
Apache hat NetBeans in der Version 10.0 Ende Dezember veröffentlicht.
Die aktuelle Version unterstützt neue Funktionalitäten aus dem JDK 11, vermisst aber immer
noch einige wichtige bzw. aktualisierte Plugins - unter anderem das Plugin zur Java EE-Entwicklung.

<!--more-->

Mit der Version 10.0 hat Apache das zweite offizielle Release unter dem Dach der Apache Software Foundation (ASF) am 27. Dezember 2018 veröffentlicht. Die Entwicklungsumgebung befindet sich immer noch im Apache Incubator und in der Transitionsphase zu Apache. 

Das bedeutet, dass noch nicht alle Codepassagen durch Oracle an die Apache Software Foundation (ASF) übergeben worden sind und die Überprüfung des Codes auf Konformität zur Apache License noch nicht vollständig abgeschlossen sind.

NetBeans 10.0 unterstützt die im JDK 11 implementierten neuen Funktionalitäten wie _var_-Support für implizit typisierte Lamda-Ausdrücke. Java-Entwickler wird weiter freuen, dass die Unterstützung für JUnit 5 weiter optimiert wurde.

Zudem wurde die Unterstützung für verschiedene PHP-Versionen verbessert. Mit dem aktuellen Stand der Entwicklungsumgebung lassen sich problemlos Java SE-, Scala-, Groovy-, JavaScript- und PHP-Anwendungen erstellen.

Bereits seit der Portierung fehlt die Unterstützung für Java EE-Anwendungen, da der Code von Oracle bisher nicht offiziell an die ASF übergeben worden ist. Inwieweit das Plugin offiziell für NetBeans wieder verfügbar sein wird, ist mit dem Entfernen der Java EE-Pakete aus dem JDK 11 immer mehr fraglich.

Wer dennoch Java EE-Anwendungen mit NetBeans entwickeln will, der kann das [offizielle Plugin-Repository von NetBeans 8.2 einbinden](https://dzone.com/articles/notes-on-java-eejakarta-ee-support-for-netbeans-9) und neben dem Java EE-Plugin auch noch weitere Plugins installieren, die weder in NetBeans 9.0 noch 10.0 verfügbar sind.

Nachdem sich NetBeans seit 2016 in der Incubator-Phase befindet, hat sich bisher nur der Kern weiterentwickelt. Viele der Plugins sind nach wie vor nicht auf die Version 9.0, geschweige denn auf die Version 10.0 portiert bzw. auf Kompatibiltät geprüft worden.

Weiterhin existiert kein Installer für die unter dem Hause der ASF weiterentwickelten Version. Die kompilierten Binär-Versionen müssen auch mit dem zweiten Release weiterhin über Shell- oder Batch-Scripte gestartet werden. Unter Windows oder macOS fühlt sich dies nach wie vor merkwürdig an.

Alle kleinen und größeren Änderungen an NetBeans können den [offiziellen Release-Notes](https://cwiki.apache.org/confluence/display/NETBEANS/Apache+NetBeans+10) für NetBeans entnommen werden.


