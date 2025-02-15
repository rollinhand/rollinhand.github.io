type=post
title=JNI - Exception-Handling unter Windows
creator=rollinhand
date=2010-07-13
category=Entwicklung
status=published
~~~~~~
Um Exceptions aus einem JNI-Interface abzufangen und strukturiert behandeln zu können, 
sind ein paar zusätzliche Handgriffe notwendig. Dieses Post gibt einen kurzen Einblick 
über die Fallstricke und wie sie umgangen werden können.

<!--more-->

Bei der Programmierung mit dem Java Native Interface und dem Aufruf von Windows 
API-Funktionen bin ich auf Probleme gestoßen eine Exception abzufangen. 
Ein Try-Catch-Block war innerhalb von JNI nicht wirklich hilfreich.

Will man in C++ eine Exception abfangen, so definiert man meist einen  Try-Catch-Block. 
Faule Programmierer schreiben dabei meist  eine Anweisung wie:

```
try {
	// Eigentlich auszuführender  Funktionsrumpf
} catch(...) {
	// Irgendwie den Fehler behandeln
}
```

Das funktioniert so lange gut, wie es sich um Ausnahmen in der eigenen Software handelt. 
Wird JNI zu Hilfe genommen, um z.B. mittels  Java Zugriff auf native API-Funktionen des 
Betriebssystems zu erlangen, dann stößt dieser Mechanismus an seine Grenzen und das 
Programm kann  diesen Fehler bzw. diese Ausnahme nicht behandeln.

## Windows-Mechanismus für Ausnahmen
Unter Windows wird der mechanismus für die Behandlung von Software- und Hadrware-Ausnahmen 
als **Structured Exception Handling** (SEH) bezeichnet. Diese stackframe-basierte 
Ausnahmebehandlung kann mit dem Exceptionhandling in C++ bzw. Java verglichen werden, 
nutzt aber innerhalb von C++ die Schlüsselwörter __try und __except. Mit diesen 
Schlüsselwörtern kann man den Codeblock einschließen, bei denen man eine 
Exception erwartet. Bei der Programmierung mit JNI, sollte man dementsprechend alle 
Codeblöcke, die einen nativen Call an die Windows  API machen, mit diesem 
Block-Fragment umschließen:

```
__try {
	// Code
} __except(expression) {
	// Ausnahmebehandlung
}
```

Als _expression_ können die folgenden Werte angegeben werden:
**EXCEPTION_CONTINUE_EXECUTION (-1)**
Der Handler hat für die  Ausnahmebehandlung gesorgt und nicht der __except-Block.

**EXCEPTION_CONTINUE_SEARCH (0)**
Der gerade aufgerufene  Handler kann die Ausnahme nicht behandeln und es wird auf den 
nächsten Handler gewartet bzw. danach gesucht. Diese Anweisung kann unter C++ / Java mit 
dem Umstand beschrieben werden, dass in einem Catch-Block eine Exception aufgetreten ist, 
die nicht durch den Block abgefangen wird.

**EXCEPTION_EXECUTE_HANDLER (1)**
Der __except-Block wird  ausgeführt.

Unter Windows sind die Konsole-Events und die Applikations-Threads asynchron. 
Die C-Runtime-Bibliothek ist dafür zuständig die auf der Konsole auftretenden 
Ereignisse mit den Windows-Ausnahmen zu gültigen Signalen zu vereinen.
Bei der Softwareentwicklung mittels JNI, sollten also alle Windows API-Aufrufe in 
einen __try und __except-Block gepackt werden, damit fehlerhafte Aufrufe an die API 
abgefangen werden können und an die höher gelegenen Schichten wie die Konsole oder 
die Java-Anwendung (in Form  einer Exception) weiter gereicht werden können.
