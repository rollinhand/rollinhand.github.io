--- 
layout: post 
title: "Fehlerbehebung im Glassfish-Server" 
creator: rollinhand
date: 2016-03-31 
category: Development  
--- 
Kryptische Fehlermeldungen bei der Entwicklung von Webanwendungen auf dem Glassfish-Server
sind nicht immer einfach zu entschlüsseln und deren Ursache zu beheben. Dieser
Artikel geht auf einige häufige Fehler, deren Ursachen und die Behebung ein.

<!--more--> 

Werden Web-Anwendungen mit dem Glassfish-Server 3.2.X entwickelt, so
lassen sich diese mit den entsprechenden Tools (z. B. Glassfish-Tools für
Eclipse) relativ schnell und einfach immer wieder neu auf dem Entwicklungsserver
publizieren.

Allerdings machen Entwickler Fehler, die wiederum zu einem fehlerhaften
Deployment führen können. Solche Fehler verzeiht der Glassfish-Server nicht
immer und es kommt zu kryptischen Fehlermeldungen, deren Beseitigung einige Zeit
in Anspruch nehmen kann - vorausgesetzt es ist nicht bekannt, an welchen Stellen
zu suchen ist.

In diesem Artikel stelle ich einige der kryptischen Meldungen und deren häufigste Ursache 
vor. Damit einhergehend wird auch die Lösung erläutert. Die Beispiele beziehen sich auf 
die Entwicklung mit Eclipse und den Glassfish-Tools.

### Nachträgliches Ändern einer Managed Bean
Wird der Scope einer Managed Bean (@Named) nachträglich vom Request Scope 
zum Session Scope geändert, so muss das Interface _Serializable_ implementiert werden. 
Wird dies vergessen, so wird das Deployment der Managed Bean durch WELD verhindert und 
eine Fehlermeldung ausgegeben.

Mit einer einfachen Korrektur und dem erneuten Deployment ist es anschließend nicht getan. 
Der Glassfish-Server verhindert das Deployment mit einer Exception:

``
com.sun.enterprise.container.common.spi.util.InjectionException: Fehler beim Erstellen des 
verwalteten Objekts für Klasse: class org.jboss.weld.servlet.WeldListener
``

Abhilfe kann hier geschaffen werden, indem der Glassfish-Server gestoppt und das 
Deployment-Verzeichnis bereinigt wird. Untrügliche Anzeichen für ein fehlgeschlagenes 
Deployment ist ein Verzeichnis beginnend mit dem Namen **_xfer**.

### Deployment einer Webanwendung (WAR) schlägt fehl
In diesem Szenario schlägt das Hot Deployment einer Webanwendung innerhalb von Eclipse 
mittels Publish (Strg+Alt+P) fehl. Das Glassfish-Logfile meldet, dass das Webarchiv (WAR) 
noch vorhanden ist.

Betrachtet man das Applikationsverzeichnis auf dem lokalen Glassfish-Server unter 
`$DOMAINDIR/applications/$meine-app` so befindet sich dort eine Datei mit der Bezeichnung 
**.staleFiles**.

In dieser Datei sind Dateien und Verzeichnisse gelistet, die nicht automatisch vom 
Glassfish undeployt werden konnten. Bei einem Redeployment der Anwendung über die 
Glassfish-Tools wird in der Regel die Anwendung vollständig inkl. aller abhängigen 
Bibliotheken entfernt.

Damit das Deployment wieder lauffähig ist, kann nur Abhilfe durch Stoppen des 
Glassfish-Servers und manuellem Löschen der Anwendung geschaffen werden.

Damit das Deployment wiederholt erfolgreich funktioniert, ist zu prüfen, ob zusätzlich 
dem Projekt hinzugefügte Bibliotheken nicht entfernt werden konnten. Ist das WAR Teil einer 
Enterprise-Applikation (EAR), dann gehören die Bibliotheken in das lib-Verzeichnis des EAR 
und nicht in das WAR. Ansonsten kann der Glassfish-Server die abhängigen Bibliotheken 
nicht entfernen.

### CommandException während des Deployments
Eine Fehlermeldung, die mir bisher nur in Verbindung mit Eclipse und den Glassfish-Tools 
untergekommen ist, ist die CommandException. Während des ersten oder eines erneuten 
Deployment erscheint die Meldung:

``
org.glassfish.tools.ide.admin.CommandException: Can not read
  HTTP response, caught IOException Schwerwiegend: EJB-Modul kann nicht geladen
  werden. DeploymentContext enthält kein EJB.
``
  
Meine Projekte baue ich meist mit Maven. Erscheint diese Meldung beim Deployment 
innerhalb der Eclipse nach einer Änderung an der pom.xml, so ist das Eclipse-Projekt 
nicht mehr korrekt synchronisiert. Abhilfe schafft hier in einem Großteil der Fälle 
die Option _Maven &gt; Update Project_ (Alt + F5). 

Sie befindet sich im Kontextmenü des Projekts.
