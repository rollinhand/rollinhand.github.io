~~~~~~
type=post
title=SQLPlus mit Homebrew installieren
date=2022-09-05
category=DevOps
tags=[SQLPlus,Homebrew,Mac]
~~~~~~
Homebrew ist der ultimative Paketmanager für macOS.
Auch eher dem kommerziellen Bereich zuzuordnende Software wie bspw. Oracle SQLPlus lässt sich über Homebrew installieren.

<!--more-->

Die Installation über Homebrew ist denkbar einfach und erfordert keine manuellen Schritte, 
kein Akzeptieren von Lizenzvereinbarungen und auch kein Kopieren von Dateien in irgendwelche Ordner.

Im _Terminal_ müssen lediglich die folgenden drei Befehle abgesetzt werden:

```
$ brew tap InstantClientTap/instantclient
$ brew install instantclient-basic
$ brew install instantclient-sqlplus
```

Anschließend ist `sqlplus` im Pfad verfügbar.

Danke an [Joost van Wollingen für diesen Tipp](https://vanwollingen.nl/install-oracle-instant-client-and-sqlplus-using-homebrew-a233ce224bf).
