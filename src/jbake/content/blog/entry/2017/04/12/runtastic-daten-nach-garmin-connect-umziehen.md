type=post
title=Runtastic Daten nach Garmin Connect umziehen
date=2017-04-12
category=Allgemein
tags=Garmin, Runtastic 
~~~~~~
Aktivitätsdaten von Runtastic zu einem anderen Anbieter umzuziehen ist nicht leicht. Welche Fallstricke
bei einem Umzug nach [Garmin Connect](http://connect.garmin.com) zu erwarten sind, zeige ich in diesem Beitrag.

<!--more-->

Vorab ist zu sagen, dass die 
[einschlägigen Lösungen für einen Massenexport](https://blog.dafb-o.de/massenexport-von-runtastic-aktivitaeten/) 
der bei Runtastic gespeicherten
Daten seit einigen Monaten nicht mehr möglich ist. Der Anwender bekommt bei einem mehrfachen Download von
Aktivitäten im Format TCX oder GPX ein Google-Captcha angezeigt. Runtastic verifiziert damit, dass der
Download nicht durch einen Roboter durchgeführt wird. Implizit soll durch diese Hürde natürlich der Umzug
zu einem anderen Portal wie [Strava](http://www.strava.com) oder [Garmin Connect](http://connect.garmin.com) 
erschwert werden.


### Was ist beim Umzug nach Garmin Connect zu berücksichtigen?
Hat man sich letztendlich doch dazu entschieden, die einzelnen Aktivitäten nach Garmin oder Strava 
umzuziehen, so sollte nach Möglichkeit als Export-Format **TCX** gewählt werden. In diesem Format lässt sich die
Aktivität auch klassifizieren. Dies hilft dabei, dass bei Garmin Connect oder Strava die Aktivität nicht
noch manuell klassifiziert werden muss, sondern beim Import automatisch korrekt erkannt wird.

Allerdings gibt es beim Export von Runtastic noch einen weiteren Pferdfuß über den ich gestolpert bin.
Die durch Runtastic vorgenommene Klassifikation in den TCX-Dateien ist nicht mit den bei Garmin 
hinterlegten Aktivitäten kompatibel.

Daher ist es notwendig, die Dateien nach dem Export zu bearbeiten. Für die Aktivität Laufen muss dabei die
Klassifikation _running_ durch _Running_ und beim Radfahren die Klassifikation _cycling_ durch _Biking_
ersetzt werden. Schnell und einfach geht das unter macOS oder Linux in einem Terminal mit den folgenden
zwei Zeilen Code:

{% highlight Shell%}
for file in $( ls ); do sed -i '' 's/running/Running/g' $file; done
for file in $( ls ); do sed -i '' 's/Swimming/Other/g' $file; done
for file in $( ls ); do sed -i '' 's/cycling/Biking/g' $file; done
{% endhighlight %}

Ebenfalls zu beachten ist, das bei einem Export die Zwischenzeiten nicht übernommen werden. Allerdings sollte
dies für ältere Aktivitäten verschmerzbar sein.