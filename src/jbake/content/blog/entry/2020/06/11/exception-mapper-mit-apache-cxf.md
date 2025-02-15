type=post
title=Exception Mapper mit Apache CXF
date=2020-06-11
category=Entwicklung 
tags=Meecrowave,Apache CXF,REST
~~~~~~
Exception Mapper in Verbindung mit REST-Services vereinfachen nicht nur den Code, sondern sorgen
auch dafür, dass Exceptions identisch behandelt und den gleichen Fehlercode an den Aufrufer
zurückliefern. In diesem Blog-Beitrag zeige ich, wie das mit [Apache CXF][cxf] und 
[Meecrowave][meecrowave] funktioniert
und die Anwendung auch für andere Servlet-Container oder Java EE-Server portabel bleibt.

<!--more-->

## Die individuelle Exception werfen
Exceptions sind dazu geschaffen worden, einer Methode die Möglichkeit zu bieten, die Verarbeitung
umgehend und kontrolliert zu beenden und das "Problem" an den Aufrufer zu delegieren. Anstatt nun
auf die Standard-Exceptions der Sprache Java zu setzen, erweist es sich als Good Practice eigene
Exceptions zu definieren, um so die Verarbeitung im eigenen Code gezielter beeinflussen zu können.

Gerade im Domain Driven Design sollten Objekte ihre eigenen Exceptions mitbringen, um in der
gemeinsamen Sprachwelt (Ubiquitous Language) zu bleiben.

Bei der Verwendung von REST-Services in
einer Anwendung, kann der Service (der Aufgerufene) auch das Problem an den Aufrufer delegieren.
Gründe hierfür könnten sein, dass

* übergebene Parameter nicht plausibel sind,
* angeforderte Daten nicht verfügbar sind,
* die aufgerufene Aktion auf einen Fehler gelaufen ist.

Es lassen sich sicherlich noch viel mehr Gründe finden. Für mein Beispiel greife ich wieder auf den
[Person-Server][github] zurück, der auch schon im initialen [Blogbeitrag zu Meecrowave][meecrowave]
herangezogen worden ist.

Im Model ist die Klasse `PersonException` definiert, die im Backend immer geworfen wird, wenn eine
Aktion auf einem Objekt der Klasse `Person` fehlschlägt. Es handelt sich dabei um eine
`RuntimeException`, sodass diese auch nicht bei jedem Methodenaufruf definiert werden muss.

## Der REST-Endpunkt
Im Beispiel existiert der REST-Endpunkt `PersonEndpoint`, der verschiedene Aktionen bzw. Methoden
zur Verfügung stellt. Ein Auszug ist im Folgenden dargestellt:

```java
@RequestScoped
@Path("/person")
public class PersonEndpoint {
  @Inject
  private IPersonService personService;

  @DELETE
  @Path("/{id}")
  public Response removeById(@PathParam("id") String id) {
    personService.removeById(id);
    return Response.ok().build();
  }
  // snipped other methods
}
```

Die Klasse `PersonEndpoint` delegiert die Aufrufe an eine Implementierung von `IPersonService` und
überlässt dieser die Verarbeitung. Für den weiteren Verlauf des Beispiels beschränke ich mich auf
die Methode zum Löschen einer Person über ihre ID. (`removeById`).

Ist der Aufruf erfolgreich, so wird der HTTP-Status OK (200) an den Aufrufer zurückgeliefert. Aber
was passiert, wenn der Aufruf scheitert, weil über die ID keine Person zur Löschung gefunden werden
kann? Die Code-Passage im obigen Beispiel lässt auf den ersten Blick vermuten, dass immer OK an den
Aufrufer zurückgeliefert wird.

Im ersten Moment kribbelt es in den Fingern, die Code-Passage vielleicht so zu ändern:

```java
@DELETE
@Path("/{id}")
public Response removeById(@PathParam("id") String id) {
  if (personService.removeById(id)) {
    return Response.ok().build();
  } else {
    return Response.notModified().build();
  }	
}
```

Schön geht anders und die Zeiten, dass Methoden oder Funktionen ihren Status über Codes oder
boolesche Werte mitteilen sind seit der objektorientierten Programmierung und der Einführung von
Exceptions vorbei.

Ein Blick auf die Methode `removeById` im eigentlichen Service bringt mehr Klarheit:

```java
@Override
public void removeById(String id) {
  Optional<Person> person = findById(id);

  if (person.isPresent()) {
    log.info("Removing person {}", person);
    remove(person.get());
  } else {
    throw new PersonException("Person with UUID " + id + " not found");
  }
}
```

Kann die Person nicht gefunden werden, so wird die `PersonException` geworfen. Damit innerhalb des
REST-Services keine Catch-Routinen eingeführt werden müssen, existieren im JAX-RS Standard Exception
Mapper, die genau diese Rolle übernehmen und dafür sorgen, dass der Code aufgeräumter wirkt und einen
aspektorientierten Ansatz bekommt.

## Exception Mapper mit Apache CXF
Mit [Apache CXF][cxf] lassen sich einfach REST- und SOAP-Services implementieren. Für REST bietet Apache
CXF eine JAX-RS konforme Implementierung, sodass sich Exception Mapper definieren und einbinden
lassen. Im Beispiel sieht der Exception Mapper wie folgt aus:

```java
@Provider
public class PersonExceptionMapper implements ExceptionMapper<PersonException>{
  @Override
  public Response toResponse(PersonException exception) {
    return Response.status(Status.NOT_ACCEPTABLE).entity(exception.getMessage()).build();
  }
}
```

Der Mapper sorgt dafür, dass jede im REST-Kontext über den `PersonService` geworfene
`PersonException` abgefangen und in einen HTTP-Response mit einem einheitlichen Status gepackt wird.

Über die Annotation _@Provider_ definiert der JAX-RS Standard, dass so Erweiterungen bekannt gemacht
werden können. Leider interpretiert Apache CXF diese Annotation zum Zeitpunkt dieses Beitrags noch
nicht und auch die Implementierung in Meecrowave bietet hierfür noch keine Unterstützung.

Nur mit dieser Code-Passage wird die Exception folglich ungefiltert geworfen und führt zu einem
"wunderbaren" Stack-Trace den wir nicht sehen wollen. Abhilfe lässt sich über die _beans.xml_
schaffen, die je nach Paketierung entweder in den Verzeichnissen WEB-INF oder META-INF abgelegt werden sollte.

Dort kann die Erweiterung Apache CXF bekannt gemacht werden:

```xml
<jaxrs:server id="personServer" address="/">
    <jaxrs:serviceBeans>
        <ref bean="org.kivio.server.endpoints.PersonEndpoint" />
    </jaxrs:serviceBeans>
    <jaxrs:providers>
        <bean
            class="org.kivio.server.endpoints.NullPointerExceptionMapper" />
        <bean
            class="org.kivio.server.endpoints.PersonExceptionMapper" />
    </jaxrs:providers>
</jaxrs:server>
```

Über die zusätzliche Konfiguration in der _beans.xml_ wird zunächst im Attribut _serviceBeans_
festgelegt, welche Beans REST-Services nach dem JAX-RS Standard sind. Über das Attribut _providers_
werden die Klassen benannt, die Erweiterungen für JAX-RS bieten.

Mit CURL kann die Funktionalität getestet werden:

```sh
curl -v -XDELETE http://localhost:8080/person/2020
```

Und erhalten als Ausgabe einen sauberen HTTP-Response und keinen Stack-Trace.

```
> DELETE /person/2020 HTTP/1.1
> Host=localhost:8080
> User-Agent=curl/7.64.1
> Accept=*/*
> 
< HTTP/1.1 406 
< Date=Thu, 11 Jun 2020 14:14:42 GMT
< Content-Type=application/octet-stream
< Content-Length=31
< 
* Connection #0 to host localhost left intact
Person with UUID 2020 not found* Closing connection 0
```

## Portabilität
Wird die Anwendung in einem Java EE-Server betrieben, der keine Apache CXF-Implementierung sondern
Jersey oder RESTEasy nutzt, kann die Konfiguration in der _beans.xml_ entfallen.

## Zusammenfassung
Mit Exception Mappern lässt sich auch in Verbindung mit Apache CXF verständlicher und schlanker Code
schreiben. Boilerplate-Code innerhalb des REST-Services wird somit vermieden und Exceptions werden
nach außen einheitlich behandelt. Die Idee hinter Exceptions, den Fehler an den Aufrufer zu
delegieren wird direkt unterstützt. Auch wenn zusätzliche Konfiguration in der _beans.xml_ notwendig
ist, bleibt die Anwendung dennoch portabel.

[github]=https://github.com/rollinhand/meecrowave-example
[meecrowave]={% post_url 2020-04-30-meecrowave-microservices-ohne-aufwandiges-framework %} 
[cxf]=http://cxf.apache.org
