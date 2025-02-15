~~~~~~
type=post
title=SD-Karten verhindern MacBook Standby
date=2018-05-31
category=Allgemein
tags=[Apple, MacBook, JetDrive]
~~~~~~
In meinem [Post vom 31.12.2016]({% link _posts/2016-12-31-itunes-bibliothek-auf-transcend-jetdrive.md %}) habe ich gezeigt, dass die iTunes Bibliothek auf eine externe SD-Karte ausgelagert werden kann. Allerdings hat das dauerhafte Mounten einer SD-Karte den Nachteil, dass das MacBook nicht mehr in den Standby-Modus wandert.

<!--more-->

Seit einiger Zeit habe ich mich gewundert, dass nach einem halben Tag das MacBook in der Tasche ca. 25 Prozent an Akku-Leistung verloren hat. Normalerweise verbraucht ein MacBook bei zugeklappten Deckel ca. ein Prozent Akku-Leistung je Stunde.

Nach drei Stunden geht das MacBook in den Standard-Einstellungen in den Tiefschlaf und reduziert dabei die CPU-Leistung sofern keine Dienste im Hintergrund laufen, die den Tiefschlaf (nicht mit dem Hibernate-Modus zu verwechseln) verhindern.

[Apple hat am 12.10.2017 ein Dokument veröffentlicht](https://support.apple.com/de-de/HT202124) und weist darauf hin, dass eine dauerhaft gemountete SD-Karte den Tiefschlaf verhindert und somit die Akkuleistung schneller schwindet.

Die dauerhafte Einbinung eines JetDrives für die Auslagerung der iTunes-Datenbank sorgt folglich dafür, dass der Standby-Modus nicht mehr genutzt werden kann. 

Um den Akku zu schonen kann also die SD-Karte ausgeworfen oder das MacBook bei längerer Nicht-Nutzung ausgeschaltet werden. Umgerechnet ist ansonsten mit ca. 3 Prozent Leistungsschwund je Stunde bei dauerhaft eingebundener SD-Karte zu rechnen.

Im Internet kursieren auch Tipps, um Den Standby-Modus des MacBooks zu beeinflussen. Ich persönlich rate allerdings davon ab, die Powermanagement-Einstellungen des MacBooks über die Kommandozeile zu beeinflussen, wenn man sich nicht der Konsequenzen bewusst ist.
