type=post
title=Blog zu GitHub pages umgezogen
date=2016-12-23
creator=rollinhand
category=Allgemein
~~~~~~
Meinen Blog [Kivio](http://kivio.org) habe ich zum Ende des Jahres zu [GitHub pages](http://github.com) 
umgezogen. Die Gründe finden sich in diesem Post.

<!--more-->

Bisher wurde das Blog mit [Apache Roller](http://roller.apache.org) auf einem virtuellen Server
bei 1&1 gehostet. Da es aber wenige dynamische Inhalte in dem Blog gibt und nur eine 
Instanz des Blogs gehostet wird, ist der Betrieb eines eigenen Webservers nicht nur
unwirtschaftlich sondern überdimensioniert.

GitHub bietet mit GitHub Pages eine einfache und komfortable Lösung, statische Seiten
zu hosten. Angetrieben wird GitHub Pages von [Jekyll](http://jekyllrb.com) einem auf
Ruby basierenden statischen Webseiten-Generator. Als Autor besteht die Möglichkeit seine 
Sourcen bei GitHub in einem Repository abzulegen oder aber nur die kompilierte statische Seite.

Ich habe mich für die erste Variante entschieden, denn somit kann ich auch meine Sourcen
versionieren und Jekyll übernimmt die Übersetzung der Seite auf Seiten von GitHub. Allerdings
bringt diese Variante auch Einschränkungen mit sich=Es können nur durch GitHub ausgewählte
Plugins mit Jekyll verwendet werden. Damit keine bösen Überraschungen beim Veröffentlichen
auftreten und es zu Fehlern bei der Bereitstellung kommt, bietet es sich an, ein
_Gemfile_ anzulegen und dort, das _github-pages_ gem einzubinden:

	source "https://rubygems.org"
	gem 'github-pages', '109', group=:jekyll_plugins

Das Repository zu [github-pages](https://github.com/github/pages-gem) enthält eine ausführliche
README und Verweise, welche Plugins unterstützt werden.

Einen guten Einstieg zu GitHub pages bieten die beiden folgenden Quellen:


* [Setting up your GitHub Pages site locally with Jekyll](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/)
* [Creating and Hosting a Personal Site on GitHub](http://jmcglone.com/guides/github-pages/)


Der Übertrag der alten Posts aus Apache Roller gestaltete sich allerdings nicht als
sonderlich trivial. Apache Roller fristet inzwischen ein Nischendasein und findet kaum
Berücksichtigung. Somit bietet auch Jekyll keine Möglichkeit automatisch Blog-Posts zu
übernehmen. Für weiter verbreitete Blogging-Lösungen wie Wordpress, Joomla oder Typo
bietet Jekyll Importer. Aber dazu in einem später folgenden Beitrag mehr Details.

Die Übertragung der Posts unter kivio.org ist daher noch nicht vollständig und fehlende
Posts werden in den kommenden Wochen noch ergänzt...

Viel Spaß beim Lesen.


