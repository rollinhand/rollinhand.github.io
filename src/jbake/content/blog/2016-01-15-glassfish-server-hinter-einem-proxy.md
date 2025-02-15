~~~~~~
type=post
title=Glassfish-Server hinter einem Proxy betreiben
creator=rollinhand
date=2016-01-15
category=Technologie
~~~~~~
Wie nutzt man den NGINX effizient als Proxy für einen Glassfish und wie bekommt man den 
Port 8080 dauerhaft aus Links seiner Web-Anwendung entfernt? Die Antworten liefert dieser Beitrag.
<!--more-->
Der NGINX Webserver ist ein kleiner, schlanker Webserver, der sich hervorragend als Proxy-Server 
für einen schwergewichtigen Applikationsserver wie den Glassfish nutzen lässt. Einen 
Proxy-Server vor einen Applikationsserver soll zum einen dafür sorgen, den Applikationsserver 
abzusichern aber auch statische Inhalte schneller auszuliefern.

Mit einem Proxy-Server ist es somit möglich alle Anfragen über den Port 80 an den 
Applikationsserver weiterzuleiten und auch ein URL-Rewriting vorzunehmen. Beides war 
notwendig als ich Apache Roller für meine neue Domain www.kivio.org einsetzen wollte. 
Und das waren die Bedingungen, die NGINX als Proxy erfüllen sollte:

* Alle Aufrufe sollten über den Port 80 laufen, sodass der Well-known Port 8080 durch die Firewall geschützt werden kann und die Requests intern auf dem Server weitergereicht werden.
* Apache Roller erstellt Blog-URLs nach dem Schema http://domain/roller/*blog-name.* Natürlich sollten die Inhalte der Frontpage bzw. des primären Blog natürlich über [www.kivio.org](http://www.kivio.org) erreichbar sein.
* Die Anfragen an die alte Domain [www.berg-systeme.de](http://www.berg-systeme.de) sollten auf eine vordefinierte, statische Landing-Page geroutet werden.

Mit diesen Bedingungen im Hinterkopf, war die Erstkonfiguration schnell erledigt.

In der Konfigurationsdatei /etc/nginx/sites-available/default habe ich folgende Anpassungen vorgenommen:

```
server {
   listen 80 default_server;
   listen [::]:80 default_server ipv6only=on;

   index index.html index.htm;

   # Make site accessible from http://localhost/
   server_name www.kivio.org www.kivio.biz www.kivio.eu;

   location / {
        proxy_pass http://www.kivio.org:8080/;
   }
}
```

Nach einem Neustart des NGINX bzw. einem Neueinlesen der Konfiguration mittels /etc/init.d/nginx 
reload werden alle Anfragen auf die Startseite des Glassfish-Servers weitergeleitet. 
Mit Aufruf der URL [www.kivio.org/roller/blog](http://www.kivio.org/roller/blog) passierte es allerdings, 
dass alle erzeugten Links und verlinkten Ressourcen in der Anwendung immer noch den 
Port 8080 beinhaltet haben. Sobald der Port gesperrt werden würde, wäre es natürlich nicht 
möglich die Ressourcen wie CSS oder JavaScript zu laden, geschweige denn die verlinkten Seiten zu besuchen.

### Was also tun?
Der Virtaul Server des Glassfish schafft hier Abhilfe. Er muss eh noch konfiguriert werden, 
sodass Apache Roller immer als Standardanwendung geladen wird, wenn ein Besucher die URL einfach aufruft.

Über die Admin Konsole kann unter **Configurations &gt; server-config &gt; Virtual Servers** 
die Konfiguration geändert werden. Unter server sind die Konfigurationen für 
HTTP-Requests (http-listener-1) und HTTPS-Requests (http-listener-2) zusammengefasst.

Über **Default Web Module** kann festgelegt werden, welche bereitgestellte Anwendung 
standardmäßig genutzt werden soll.

Da über den http-listener-1 die einfachen HTTP-Anfragen einlaufen, muss dieser nun auch 
noch konfiguriert werden. Über HTTP-Service > Http Listeners > http-listener-1 kann 
ein Alias-Name für den Rücktransfer der Daten an den Client festgelegt werden.

Unter **Server Name** wird einfach [www.kivio.org:80](http://www.kivio.org:80 ) 
eingetragen und der Glassfish neu gestartet.

Nach dem Neustart ist der Port aus allen URL-Angaben verschwunden.

Fehlt also nur noch die Erfüllung der Anforderung für die statische Weiterleitung von www.berg-systeme.de.

### Statische Weiterleitung
Die statische Weiterleitung auf die Landing page ist nach den vorherigen Anpassungen 
kein Problem mehr. Damit der NGINX auf die Domäne [www.berg-systeme.de](http://www.berg-systeme.de) 
reagiert wird eine eigene Server-Passage in die Konfigurationsdatei eingefügt:

```
server {
   listen 80;
   server_name www.berg-systeme.de;

   location / {
      proxy_pass http://localhost:8080/roller/kivio/page/de/bergsysteme;
      break;
   }
}
```

Damit findet eine transparente Weiterleitung statt.
