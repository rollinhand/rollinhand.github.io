---
layout: post
title: Meecrowave - Microservices ohne aufwändiges Framework
date: 2020-04-30
category: Entwicklung
tags: [Meecrowave,Microservices]
---
Die Apache Foundation hat mit [Meecrowave][meecrowave] einen Microprofil-Server auf den Weg gebracht, der durch
seine geringe Größe und niedrigen Speicherverbrauch besticht. Inwiefern er genutzt werden kann, um
einfach Microservices zu schreiben, habe ich mir genauer angesehen.

<!--more-->

Apache Meecrowave ist ein Server, der ausschließlich auf Technologien der Apache Foundation basiert
und in seiner Basisausstattung überschaubar ist. Im Kern werkelt eine Tomcat-Server als
Servlet-Container und zusätzlich sind die folgenden Komponenten enthalten:

* CDI ([OpenWebBeans][openwebbeans])
* JAX-RS ([CXF][cxf])
* JSON ([Johnzon][johnzon])

Zum Erstellen eines einfachen Microservice ist lediglich eine Maven-Abhängigkeit zu definieren und
schon kann mit der Entwicklung des eigenen Microservice begonnen werden.

```
<dependency>
  <groupId>org.apache.meecrowave</groupId>
  <artifactId>meecrowave-core</artifactId>
  <version>${meecrowave.version}</version>
</dependency>
```

Meecrowave ist derzeit in der Version 1.2.9 verfügbar. Die Version stammt von September 2019. Seitdem
hat sich an den EE-Spezifikationen wenig verändert, sodass keine neuen Komponenten veröffentlicht
worden sind.

Mit dem Maven-Goal `meecrowave:bundle` lässt sich ein ZIP-Archiv erzeugen, dass alle notwendigen
Abhängigkeiten und Start-Skripte beinhaltet, sodass ein in sich geschlossener Service ausgeliefert
oder in einen Docker-Container deployt werden kann. Das Deployment in einen Docker-Container
beschreibe ich in einem anderen Blog-Beitrag.

Doch zurück zum eigentlichen entwickeln mit Meecrowave. Zur besseren Nachvollziehbarkeit, welche 
Möglichkeiten in Meecrowave stecken, habe ich auf [GitHub][github] ein Projekt angelegt. Es besteht aus zwei
Modulen und soll ein etwas komplexeres Beispiel statt dem üblichen Hello World darstellen:

* person-model: Enthält unsere Modellklassen, die von der Verarbeitungslogik separiert sind.
* person-server: Enthält unseren Microservice auf Basis von Meecrowave.

Für diesen Blog-Beitrag relevant ist nur das Modul _person-server_. Und das schauen wir uns nun
genauer an.

## Eine Starterklasse anlegen

Um eine Instanz von Meecrwave starten zu können, wird eine Startklasse benötigt. Der Name der Klasse
ist hierbei gleichgültig - ich habe sie _Starter_ genannt - sie muss lediglich eine statische
Main-Methode enthalten in der Meecrowave konfiguriert und gestartet wird.

```java
public class Starter {
  public static void main(String[] args) {
    Meecrowave.Builder builder = new Meecrowave.Builder();
    builder.setHttpPort(8080);
    
    try(final Meecrowave meecrowave = new Meecrowave(builder)) {
      meecrowave.bake().await();
    }
  }
}
```

Eine Meecrowave-Instanz lässt sich programmatisch, per Konfigurationsdatei oder durch Parameter auf
der Kommandozeile konfigurieren. In dem gezeigten Beispiel wird der Listener-Port auf 8080
konfiguriert. Weitere Parameter wären über den Builder möglich. Auf den Seiten zum
Meecrowave-Projekt findet sich eine lange Liste der Einstellmöglichkeiten.

Durch `bake()` wird der Server gestartet und mit `await()` in den Modus versetzt, auf eingehende
Requests zu warten. Mit der laufenden Instanz im Hintergrund kann nun der eigentliche REST-Service
implementiert werden.

## Einen REST-Service implementieren

In dem Person-Server können die Mitglieder einer Familie angezeigt, entfernt oder neue hinzugefügt
werden. Unser Beispiel implementiert also einen typischen CRUD-Service. Mit den bekannten JAX-RS
Annotationen haben wir in Kürze in der Klasse _PersonEndpoint_ einen REST-Service implementiert.

```
@RequestScoped
@Path("/person")
public class PersonEndpoint {
  @Inject
  private IPersonService personService;
	
  @POST
  public Response createPerson(Person person) {
    personService.add(person);
    return Response.status(Status.CREATED).entity(person).build();
  }
	
  @DELETE
  public Response removePerson(Person person) throws PersonException {
    personService.remove(person);
    return Response.ok(person).build();
  }
	
  @GET
  public Response listAll() {
    return Response.ok(personService.listAll()).build();
  }
  [...]
}
``` 

Beim Start des Containers wird die Klasse gefunden und der Endpunkt registriert. Mit _curl_ oder
_Postman_ kann mit den Endpunkten interagiert werden. Die eigentliche Geschäftslogik für die
Bereitstellung der Daten wurde wiederum in einem eigenen Service bzw. einer eigenständigen Bean
gekapselt. Die Arbeitsweise des Services dürfte durch die sprechenden Methodennamen selbsterklärend
sein. Für die Details zur Arbeitsweise lohnt sich ein Blick in das [Repository][github].


```
curl http://localhost:8080/person
[{"id":"e0f6bf13-2deb-4831-a779-5aa34fe7e5e6","name":"Simpson","surname":"Homer"},
{"id":"3348f546-4ab3-4af0-97c4-6ce8a2d04ce1","name":"Simpson","surname":"Marge"},
{"id":"81a038aa-5dd7-4550-9cff-b2dab4b59c9a","name":"Simpson","surname":"Bart"},
{"id":"7e5ee7a1-70d5-4540-b304-36a67bb969f1","name":"Simpson","surname":"Lisa"},
{"id":"a6e08d08-f6b2-4e9d-98b8-a80ffd5f04e7","name":"Simpson","surname":"Maggie"}]
```

## TDD mit Meecrowave

Spring wird für seine gute Testbarkeit gelobt. Insbesondere Integrationstests sind in Spring
einfacher zu erstellen als in Java EE. Wer im EE-Kontext Integrationstests schreiben will, muss sich
erst umständlich in [Arquillian][arquillian] einarbeiten.

Die Entwickler von Meecrowave haben diesen Umstand berücksichtigt und ein zusätzliches Plugin
geschaffen, dass in Maven eingebunden, dafür sorgt, dass Test Driven Development mit Meecrowave
komfortabel möglich ist. Und es arbeitet perfekt mit JUnit 4 und JUnit 5 zusammen.

```
<dependency>
  <groupId>org.apache.meecrowave</groupId>
  <artifactId>meecrowave-junit</artifactId>
  <scope>test</scope>
  <version>${meecrowave.version}</version>
</dependency>
```

Es kann mit _meecrowave-junit_ ein oder mehrere Endpunkte getestet werden. Dazu wird zu Beginn der
Tests der Container hochgefahren. Da für die Tests ggf. Informationen aus der Konfiguration des
Servers notwendig sind, können diese über die Junit 5 Erweitereung `@MonoMeecrowaveConfig`
ausgelesen werden.


```
@MonoMeecrowaveConfig
public class PersonEndpointTest {
  private WebTarget baseTarget;
	
  @ConfigurationInject
  private Meecrowave.Builder config;
	
  @BeforeEach
  public void setUp() {
    String baseUrl = String.format("http://localhost:%d/person", config.getHttpPort());
    Client client = ClientBuilder.newClient();
    baseTarget = client.target(baseUrl);
  }
	
  @Test
  public void itListsAllExisting() {
    List<Person> personList = baseTarget.request(MediaType.APPLICATION_JSON)
         .get(new GenericType<List<Person>>() {});
    
    assertNotNull(personList);
    assertFalse(personList.isEmpty());
  }
[...]
}
```

In dem Beispiel ist die Verwendung von `@MonoMeecrowaveConfig` dargestellt. Die Annotation ist
vergleichbar mit den aus Junit 4 verwendeten `@RunWith`-Annotation und sorgt dafür, dass der
Container vor der Ausführung der eigentlichen Tests hochgefahren wird.

Mit `@ConfigurationInject` haben wir die Möglichkeit auf eine Meecrowave Builder-Instanz zuzugreifen
und somit die Parameter des laufenden Containers abzufragen. Wir benutzen dies, um den Port in der
_setUp_-Methode für unsere URL zu erfahren. Diese bildet die Basis für unseren JAX-RS Client mit dem
die verschiedenen Endpunkte getestet werden sollen.

## Weitere Möglichkeiten

Wer mehr Funktionalitäten aus dem Java EE-Kontext benötigt, dem stellt das Meecrowave noch weitere
[Komponenten][meecrowave-components] zur Verfügung:

* meecrowave-jpa: Hierbei handelt es sich um einen zusätzliches Layer, dass auf JPA aufbaut und
  ähnlich wie der Server an sich mit einem Builder zur programmatischen Konfiguration der
Persistenzschicht.
* meecrowave-jolokia: Komponenten zur Integration von Monitoring auf Basis von Jolokia.
* meecrowave-oauth2: Experimentelles Modul zur Einbindung einer OAuth2-Implementiierung auf Basis
  von Apache CXF.
* Weiterhin besteht die Möglichkeit, SSL-Verschlüsselung über Let's Encrypt einzubinden.

## Zusammenfassung

Mit dem Meecrowave-Projekt hat die Apache Foundation unter der Schirmherrschaft des
[OpenWebBeans][openwebbeans]-Projekts einen kleinen, schlanken Microprofil-Server geschaffen, der auf dem Besten aus
dem Java EE-Stack aufsetzt.

Wer keine großen Frameworks für einen einfachen Microservice benötigt, der ist bei Meecrowave genau
richtig, denn eine großartige Einarbeitung ist nicht notwendig. 


[meecrowave]: https://openwebbeans.apache.org/meecrowave/
[github]: https://github.com/rollinhand/meecrowave-example/
[arquillian]: http://arquillian.org
[meecrowave-components]: https://openwebbeans.apache.org/meecrowave/components.html
[openwebbeans]: https://openwebbeans.apache.org
[cxf]: https://cxf.apache.org
[johnzon]: https://johnzon.apache.org
