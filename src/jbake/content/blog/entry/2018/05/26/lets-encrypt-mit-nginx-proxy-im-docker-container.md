type=post
title=Let's Encrypt mit Nginx Proxy im Docker Container
date=2018-05-26
category=DevOps
tags=[SSL, Nginx, Docker, Zertifikat]
~~~~~~
In diesem Tutorial beschreibe ich, wie man in einem 1&1 Cloud-Server in einem Nginx Reverse Proxy in einem Docker Container ein Let's Encrypt-Zertifikat für die SSL-verschlüsselte Verbindung einbindet.

<!--more-->

Eine Anmerkung möchte ich vorweg zu diesem Tutorial geben=Die Zertifikatseinbindung findet auf dem _nackten_ Host statt und nicht über den Let's Encrypt Docker container. Hierzu gibt es einen sehr ausführlichen Blog-Beitrag bei [Manas Tech](https://manas.tech/blog/2016/01/25/letsencrypt-certificate-auto-renewal-in-docker-powered-nginx-reverse-proxy.html), den ich ebenfalls sehr empfehlen kann.

Dieses Tutorial basiert auf der sehr rudimentären [Anleitung von 1&1](https://www.1and1.com/cloud-community/learn/networking/ssl-certificates/install-a-lets-encrypt-ssl-certificate-on-a-11-cloud-server-with-linux/) zur Installation eines Let's Encrypt Zertifikats in den standardmäßig auf einem Cloud-Server installierten Apache-Server. Ich persönlich habe Nginx dem Apache aufgrund des schonenderen Umgangs mit den Hardware-Ressourcen und der einfacheren Konfiguration vorgezogen. Die Konfiguration für den Nginx reverse proxy liegt bei [GitHub](https://github.com/rollinhand/kivio-proxy). Ich werde in diesem Post auf besondere Details der Konfiguration eingehen.

### Let's Encrypt auf dem Cloud Server installieren
Let's Encrypt ist eine freie SSL Certificate Authority - auch Root Authority genannt, die freie und kostenlose Zertifikate verteilt. Die Zertifikate sind in der Regel 90 Tage gültig und müssen spätestens dann aktualisiert werden. Am Ende des Tutorials zeige ich ebenfalls einen Weg, wie das Zertifikat regelmäßig aktualisiert werden kann.

Für die Installation des Zertifikats setze ich auf den hauseigenen Client von Let's Encrypt. Über diesen lassen sich neue Zertifikate ausstellen und bereits vorhandene jederzeit aktualisieren. Damit der Client genutzt werden kann, ist die Installation von Git auf dem Cloud-Server notwendig. Hierzu werden _root_-Rechte benötigt.

```
sudo apt-get install git
cd /opt
sudo git clone https://github.com/letsencrypt/letsencrypt
```

Im Verzeichnis `/opt/letsencrypt` liegen mehrere Scripte mit denen sich automatisiert signierte Zertifikate erstellen lassen. Für uns interessant ist hier `letsencrypt-auto`. Mit dem Parameter `--help` lassen sich die möglichen Parameter anzeigen.

Damit bei der automatischen Installation des Zertifikats auch eine Validierung durchgeführt werden kann, sollte der Nginx Proxy kurzfristig gestoppt werden, da die Ports 80 und 443 für die Validierung frei sein sollten.

```
docker stop kivio-proxy
```

Das Zertifikat soll für die Domäne depot.kivio.org erzeugt werden. Es ist zu beachten, dass bei der Ausführung des Scripts Let's Encrypt hingeht und noch einige zusätzliche Pakete unter Linux installiert. Zu diesen Paketen gehört bspw. auch Python 3.

```
./letsencrypt-auto certonly --standalone -d depot.kivio.org 
```

Dabei gibt _certonly_ an, dass kein Webserver konfiguriert werden und nur das Zertifikat installiert werden soll. Über den Parameter _--standalone_ wird temporär ein Webserver gestartet, mit dem die Domain validiert wird. Mit _-d_ werden die Domänen angegeben, für die das Zertifikat gültig ist. Jede weitere wird dabei zu den alternativen Namen aufgenommen, wenn die Validierung erfolgreich ist.

Beim Aufruf des Clients muss eine E-Mail-Adresse hinterlegt und die Nutzungsbedingungen akzeptiert werden. Die hinterlegte E-Mail-Adresse dient zur Kontaktaufnahme bei Sicherheitsproblemen oder einer anstehenden Zertifikatsverlängerung.

Sollte die Validierung der Domäne fehlschlagen, so kann über eine erneute Ausführung von `letsencrypt-auto` ein erneuter Versuch gestartet werden. Der Installer ist entsprechend fehlertolerant.

Die fertigen Zertifikatsdateien liegen anschließend unter 

`/etc/letsencrypt/live/depot.kivio.org` 

bzw. unter dem Namen der primären Domäne die bei der Registrierung angegeben worden ist.

Zeit für einen kleinen Exkurs zu den abgelegten Dateien.

### Exkurs=Zertifikatsdateien von Let`s Encrypt
War die Installation erfolgreich, dann liegen in dem Zertifikatsordner vier Dateien. Auf deren Bedeutung möchte ich im Folgenden etwas genauer eingehen, denn ein tiefergehendes Verständnis für die Dateien, hilft bei der Konfiguration von Nginx.

* __cert.pem__=Server-Zertifikat, welches für die sichere Kommunikation zwischen Browser und Server notwendig ist. Dieses kann auch selbst ausgestellt werden und gilt dann meist als nicht vertrauenswürdig.
* __chain.pem__=Intermediate Zertifikat, welches die Vertrauenswürdigkeit des Server-Zertifikats sicherstellt. Ist das Intermediate-Zertifikat nicht vorhanden, wird das Zertifikat nicht als vertrauenswürdig eingestuft. Eine entsprechende Warnung des Browsers wird aufgerufen. Die CA - in diesem Falle Let's Encrypt stellt sicher, dass der Server vertrauenswürdig ist. Aus diesem Grund muss die Validierung durch das Auto-Tool ausgeführt werden.
* __fullchain.pem__=Zusammengefügtes Zertifikat aus Server-Zertifikat und Intermediate-Zertifikat. Dieses Zertifikat wird später auch für die Konfiguration von Nginx benötigt.
* __privkey.pem__=Privater Schlüssel

### Nginx konfigurieren
Hinter der Domäne _depot.kivio.org_ läuft aktuell ein TomEE-Server, der eine kleine JSF-Anwendung hostet. Bisher war dieser Server ausschließlich über den Nginx Proxy unverschlüsselt über den Port 80 zu erreichen.

Die Konfiguration sieht bisher wie folgt aus (es handelt sich hierbei nur um einen Auszug):

```    
...
upstream depot-ee {
    server depot:8080;
}
...
server {
    listen       80;
    server_name  depot.kivio.org;

    location / {
         proxy_pass         http://depot-ee;
         proxy_redirect     off;
         proxy_set_header   Host $host;
         proxy_set_header   X-Real-IP $remote_addr;
         proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
         proxy_set_header   X-Forwarded-Host $server_name;
}
```

Ich nutze alle meine JEE Applikationsserver als Upstream-Server. Das hat den Vorteil, dass die SSL-Kommunikation nur bis zum jeweiligen Nginx-Server aufgebaut werden muss. Dies vereinfacht die Konfiguration der SSL-Kommunikation erheblich.

Die oben gezeigte Konfiguration muss dahingehend angepasst werden, dass die Proxy-Konfiguration in den Server-Block für die Kommunikation über Port 443 verschoben bzw. die Portkonfiguration für den Block geändert werden muss. Zusätzlich muss Nginx mitgeteilt werden, wo das Zertifikat und der private Schlüssel zu finden sind.

```
server {
    listen 443;
    listen [::]:443;
    server_name depot.kivio.org;

    ssl on;
    ssl_certificate /etc/letsencrypt/live/depot.kivio.org/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/depot.kivio.org/privkey.pem;
         
    location / {
        proxy_pass         http://depot-ee;
        ...
    }
} 
```

Ab sofort wäre die Webseite nur noch über https://depot.kivio.org zu erreichen. Damit die Webseite auch ohne Angabe des Protokolls erreicht werden kann, kann im Nginx noch etwas Feintuning vorgenommen werden und ein temporärer Redirect (HTTP Code 301) eingerichtet werden.

```
server {
    listen 80;
    listen [::]:80;
    server_name depot.kivio.org;
    return 301 https://depot.kivio.org$request_uri;
}
```

Dieser Eintrag sorgt dafür, dass auch eine Eingabe von `depot.kivio.org` in einem modernen Browser dafür sorgt, dass die Webseite korrekt über SSL aufgerufen wird. Der Besucher muss sich nicht merken, ob die Webseite über HTTP oder HTTPS aufgerufen wird.

Die komplette [Konfiguration](https://github.com/rollinhand/kivio-proxy/blob/master/src/main/docker/nginx.conf) befindet sich auf GitHub.

### SSL-Zertifikat verlängern
Bei den signierten Zertifikaten ist zu beachten, dass diese nur 90 Tage gültig sind. Verlängern lässt sich das Zertifikat ebenfalls über das bereits bekannte Script. So will Let's Encrypt Unmut über die kurzen Laufzeiten der Zertifikate vermeiden. 

Allerdings ist zu berücksichtigen, dass für die Erneuerung des Zertifikats der Webserver gestoppt werden muss, da ansonsten das Zertifikat nicht verifiziert werden kann.

```
/opt/letsencrypt/letsencrypt-auto certonly --renew-by-default --standalone -d depot.kivio.org
```

Die regelmäßige Verlängerung kann auch über einen Cronjob automatisiert werden. Dabei muss allerdings sichergestellt sein, dass bei der Verlängerung keine Interaktion notwendig ist.

Zu diesem Zweck habe ich mir ein Script mit dem Namen [update-certs.sh](https://github.com/rollinhand/kivio-proxy/blob/master/update-certs.sh) geschrieben, dass über einen Cronjob sonntags nachts gestartet wird und für die Aktualisierung zuständig ist.

Die _cron_ table wird mittels `sudo crontab -e` aufgerufen und bspw. die folgende Zeile hinzugefügt:

```
* 2 * * 7 /opt/update-certs.sh >> /var/log/update-certs.log
```

### SSL Zertifikat widerrufen
Ein ausgestelltes Zertifikat kann auch widerrufen werden. Dies kann notwendig werden, wenn das Zertifikat nicht mehr benötigt wird.

```
/opt/letsencrypt/letsencrypt-auto revoke --cert-path /etc/letsencrypt/live/depot.kivio.org/fullchain.pem
```

### Docker-Container öffnen
Die Nginx-Konfiguration wird in dem Standard Docker-Container verwendet. Damit auf dem Cloud-Server der Nginx auch über den Port 443 zu erreichen ist, muss er seinen Port noch nach außen freigeben.

Das passiert beim Starten des Containers. Ebenfalls wird beim Start auch das Zertifikatsverzeichnis eingebunden, sodass Nginx auch die Let's Encrypt SSL-Zertifikate findet.

```
docker run -d -p80:80 -p443:443 --restart unless-stopped --name kivio-proxy --network=kivio -v /etc/letsencrypt:/etc/letsencrypt kivio-proxy
```

Mit diesem Kommando wird der Container mit dem Docker-Netzwerk _kivio_ verbunden. In diesem Netzwerk befinden sich die JEE-Applikationsserver, die über ihren Container-Namen in der Nginx-Konfiguration referenziert werden.

Zusätzlich werden die Ports 80 und 443 nach außen exponiert, sodass der Nginx-Server auch von der Aussenwelt erreichbar ist.

