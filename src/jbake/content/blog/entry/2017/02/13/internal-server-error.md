type=post
title=Internal Server Error durch fehlerhafte EL Expression
date=2017-02-13
category=Entwicklung
tags=ADF, Oracle, Java
~~~~~~
Einen internen Serverfehler (Fehler 500) in einer ADF-Anwendung zu finden, ist nicht immer
trivial. Die Erfahrung hat mich allerdings gelehrt, dass der Fehler in 90 Prozent aller
Fälle auf eine fehlerhafte Interpretation einer EL-Expression oder fehlende Ressourcen
zurückzuführen ist.

<!--more-->

In den häufigsten Fällen handelt es sich bei ADF um eine fehlgeschlagene Auswertung einer 
EL-Expression, weil nicht der korrekte Datentyp bei der Evaluierung berücksichtigt worden 
ist.

Wird bspw. eine Variable vom Typ _DBSequence_ ausgewertet, so reicht es nicht, als 
Anweisung folgendes zu schreiben: 


```
{pageFlowScope.sequence > 0}
```

Es muss auf den Wert und nicht den Objekttyp für die Evaluation des Ausdrucks zugegriffen 
werden. Hierzu sollte in den meisten Fällen 


```
#{pageFlowScope.sequence.value > 0} 
```

ausreichen. Es gibt auch die Möglichkeit die Rückgabe des Datentyps zu beeinflussen, indem 
_intValue()_ oder _doubleValue()_ genutzt wird. Eine andere Möglichkeit für die 
Evaluation des Wertes besteht im expliziten Aufruf der Methode _toString()_.
Unterstützt der Objekttyp diese Konvertierung aber nicht, so wird null zurückgegeben.

Null ist in der EL-Sprache nicht bekannt und führt so bei der Evaluation zu 
null > 0 und einer Exception. Diese wiederum resultiert in einem Fehler 500.

Um eine EL-Expression im Vorfeld zu testen, kann im Debug-Modus der EL-Evaluator des 
JDeveloper genutzt werden. Hier kann detailliert geprüft werden, wie eine EL-Expression 
funktioniert und in welchem Ergebnis ein Ausdruck resultiert.