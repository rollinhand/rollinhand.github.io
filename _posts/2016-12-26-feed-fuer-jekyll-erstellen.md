---
layout: post
date: 2016-12-26
title: "Feed für Jekyll-basierten Blog erstellen"
creator: rollinhand
category: Entwicklung
---
Ein Blog mit redaktionellen Inhalten benötigt einen Feed. Leser können so bequem die
Inhalte über einen Feed-/News-Reader abonnieren. Wie es mit Jekyll funktioniert, verrät
dieser Beitrag.

<!--more-->

Seit 2005 haben sich zwei Formate für News-Feeds etabliert: RSS 2.0 und Atom. Um alle 
Leser eines Blogs oder Nachrichtenportals abzuholen, bietet es sich an, beide Formate
zum Abonnement auf der Webseite anzubieten. Beide Formate sind unterschiedlich und haben
ihre Stärken und Schwächen.

Einen [guten Überblick über die Unterschiede](https://meiert.com/de/publications/translations/intertwingly.net/rss-2.0-and-atom-1.0/) 
der beiden Formate bietet die Übersetzung eines Artikels von Sam Ruby auf der Webseite 
von Jens Oliver Meiert.

Von Haus aus bringt [Jekyll](http://jekyllrb.com) zunächst keine Feedunterstützung mit. Auf
der Webseite des Projekts finden sich zwar Plugins zum Generieren von RSS 2.0- und Atom-Feeds;
allerdings lassen sich nicht alle Plugins mit GitHub Pages verwenden.

Die entsprechenden XML-Dateien für einen Feed basierend auf dem Atom- oder RSS 2.0-Format
zu erstellen, ist in wenigen Minuten selbst erledigt und benötigt keine zusätzlichen 
Plugins. Die beiden zur Verfügung stehenden Feeds von kivio.org sollen für diesen Beitrag
als Beispiel dienen.

Die Sourcen können direkt im Repository bei GitHub eingesehen werden:


* [atom.xml](https://github.com/rollinhand/rollinhand.github.io/blob/master/blog/feed/atom.xml)
* [rss.xml](https://github.com/rollinhand/rollinhand.github.io/blob/master/blog/feed/rss.xml)


Beide Format definieren einen festen Teil, der als Header bezeichnet werden könnte und einen
variablen Teil, der ein Listing der Blog-Einträge darstellt. Ich möchte an dieser Stelle
nicht so sehr auf das Format der beiden Feeds eingehen, sondern eher auf die Fallstricke,
die sich bei der Erstellung ergeben haben. 

Während Atom sich sehr stark an dem XML-Standard orientiert und auch die Möglichkeit besteht,
das Textformat des Feeds vorzugeben, gibt es bei RSS 2.0 zwei Fallstricke zu beachten:


* Das **Datumsformat** für pubDate entspricht nicht dem XML-Schema, sondern ist nach RFC 822 
einzugeben. Nach strftime-Notation für Ruby bedeutet das `%a, %d %b %Y %H:%M:%S %z`.
Dadurch ergibt sich ein Datum nach dem Muster _Mit, 02 Okt 2002 08:00:00 +0200_.
* Die Angabe zum **Autor** ist bei RSS 2.0 nicht in zwei getrennten XML-Elementen vorzunehmen,
sondern im _author_-Element ist zunächst die Email-Adresse und gefolgt in Klammern der
Klarname anzugeben.


Damit auch RSS- und Atom-fähige Browser erkennen, dass die Webseite entsprechende Feeds
anbieten, lassen sich diese über link-Referenzen im Header bekannt machen:

~~~ html
<html>
  <head>
    [...]
    <!-- Feeds -->
    <link rel="alternate" type="application/rss+xml" 
          title="RSS" href="/blog/feed/rss.xml" />
    <link rel="alternate" type="application/atom+xml" 
          title="Atom" href="/blog/feed/atom.xml" />
  </head>
  <body>
    [...]
  </body>	
</html>
~~~

Viel Spaß beim Nachbauen.
