~~~~~~
type=post
title=JDeveloper ohne Konsolenfenster starten
creator=rollinhand
date=2014-06-26
category=Entwicklung
~~~~~~
Nichts ist störender als neben der eigentlichen Anwendung noch ein Konsolenfenster 
geöffnet zu haben, das außer einer Ausgabe keine weitere Funktion hat. Dieser Post bringt Abhilfe.

<!--more-->

Wird der JDeveloper unter Windows aus seinem Installationsverzeichnis mit **jdeveloper.exe** 
gestartet, so öffnet sich im Hintergrund immer die Windows-Kommandozeile. Dies ist 
insofern praktisch, wenn man als Entwickler Crash-Meldungen im JDeveloper nachvollziehen 
möchte. Auf Dauer kann dies allerdings eher störend als hilfreich sein. Mit diesem 
einfachen Trick verschwindet das störende, zusätzliche Fenster.

Im Unterverzeihnis **jdev\bin** des Installationsverzeichnisses vom JDeveloper befinden 
sich plattformspezifische EXE-Dateien wie jdev.exe, jdev64.exe, jdevW.exe, jdev64W.exe.

Wie bei jeder Java-Anwendung können die mit dem Postfix **W** versehenen Binaries 
genutzt werden, um die Java Runtime ohne Konsolenfenster zu starten. 
Auf einem 64-Bit Windows kann der JDeveloper über jdev64W.exe ohne Konsolenfenster 
gestartet werden.
