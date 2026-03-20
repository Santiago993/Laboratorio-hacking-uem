#set document(
  title: "Práctica 1: Recogida de información pasiva",
  author: "Tu nombre",
  date: datetime.today(),
)

#set page(
  margin: (x: 1cm, y: 1cm)
)

#set par(
  justify: true,
  
)

#align(center)[

#v(3cm)

#text(size: 28pt, weight: "bold")[
Práctica 1: Recogida de información pasiva
]

#v(1cm)

#text(size: 18pt, weight: "bold")[
Auditoría OSINT – Naturgy
]

#v(2cm)

#image("imagenes/naturgy.png", width: 70%)
] 

#v(9cm)

#align(left)[

#text(size: 14pt)[
Alumno: Santiago Pérez Jiménez
]


#text(size: 14pt)[
Profesor: Alfredo Robledano Abasolo
]



#text(size: 14pt)[
Asignatura: Técnicas de hacking
]

#v(1cm)

#text(size: 14pt)[
Fecha: 05/03/2026
]
]


#pagebreak()

= Resumen
#v(0.40cm)
Este trabajo es sobre un análisis de reconocimiento pasivo (OSINT) aplicado a la empresa Naturgy mediante el uso de información pública. El objetivo es identificar la huella digital pública de la organización sin interactuar directamente con sus sistemas, debido a que si interactuamos directamente con la empresa se convertiría en reconocimiento activo. Para ello se han utilizado herramientas como WHOIS, Censys y técnicas de Google Dorking.

= Índice

#outline()
#pagebreak()

= Introducción
#v(0.40cm)

El reconocimiento pasivo constituye una fase fundamental dentro de cualquier auditoría de ciberseguridad. Esta fase permite obtener información relevante sobre una organización utilizando únicamente fuentes públicas, evitando la interacción directa con los sistemas objetivos.

En esta práctica se realiza un análisis OSINT de la empresa Naturgy con el objetivo de identificar su presencia digital, infraestructura visible y posibles vectores de exposición pública.

= Desarrollo

== Parte 1: investigación de registros DNS
#v(0.40cm)

Investigar y describir la función de los siguientes registros:
#table(
  columns: 4,
  stroke: 0.5pt,

  [Registro], [Descripción], [Ejemplo], [Relevancia OSINT],

  [A], [Asocia dominio a IPv4], [naturgy.es], [Identificación infraestructura],

  [AAAA], [Asocia dominio a IPv6], [IPv6 host], [Descubrimiento activos],

  [MX], [Servidor correo], [mail.naturgy.es], [Objetivos phishing],

  [TXT], [Información dominio], [SPF], [Información seguridad],

  [CNAME], [Alias dominio], [www], [Mapeo servicios],

  [NS], [Servidores DNS], [ns1], [Proveedor DNS],

  [SOA], [Autoridad DNS], [admin info], [Metadatos],

  [PTR], [Reverse DNS], [IP → dominio], [Descubrimiento hosts]
)

@blasco2013servicios Registros DNS
#v(0.50cm)

== Reconocimiento pasivo vs activo

#v(0.50cm)

El reconocimiento pasivo consiste en obtener información a través de fuentes públicas sin interactuar directamente con los sistemas objetivos.

Ejemplos de algunas herramientas que se utilizan en esta fase:

- WHOIS
- Shodan
- Censys
- Google Dorking
#v(0.5cm)

El reconocimiento activo es la fase que implica interacción directa los sistemas del objetivo para obtener información técnica detallada, como puertos abiertos, servicios activos y vulnerabilidades:

Ejemplos de algunas herramientas que se utilizan en esta fase:

- Escaneo puertos
- Nmap
- Enumeración DNS directa

#pagebreak()

== Parte 2: auditoría OSINT Naturgy
#v(0.3cm)


=== Modelo negocio
#v(0.3cm)

Naturgy es una empresa multinacional española del sector energético dedicada a la generación, distribución y comercialización de gas natural y electricidad.

@noauthor_tu_nodate ¿Qué es Naturgy?

=== Clientes:
#v(0.3cm)


- Particulares
- Usuarios residenciales (hogares)
- Empresas pequeñas y grandes

=== Servicios:

- Electricidad
- Gas
- Energías renovables
#v(0.3cm)

== Presencia digital
#v(0.2cm)


Ahora mediante las herramientas vistas en clase voy a encontrar información que se encuentre de forma pasiva sin interactuar directamente con la empresa.

=== WHOIS:
#v(0.3cm)

WHOIS es un protocolo y base de datos pública utilizada para consultar la información de registro de nombres de dominio y direcciones IP, funciona como si fuera un "directorio" de internet.

WHOIS me va a proporcionar una base del análisis cubriendo alguno de los requisitos como la infraestructura o los proveedores.

He realizado una consulta en WHOIS sobre el dominio de naturgy.es para identificar información sobre su registro.

De primeras en la web de WHOIS no he obtenido nada, porque estaba usando una web de WHOIS genérica que no muestra bien los dominios de .es

Los dominios de ".es" los gestiona la entidad española por lo tango hay muchas webs de WHOIS que no muestra dichos datos.

Entonces me tengo que ir a la web de España que es "dominios.es/es", desde ahí busco información de Naturgy:
#v(0.2cm)

#align(center)[
  #image("imagenes/WHOIS.png", width: 70%)
]



#pagebreak()
#v(0.2cm)

Desde ahí obtengo información muy interesante:

#align(center)[
  #image("imagenes/WHOIS2.png", width: 55%)
  #v(0.2cm)

  #image("imagenes/WHOIS3.png", width: 55%)
]
@liu2015learning WHOIS

Los datos más importantes son:

Primero su infraestructura y proovedores:

- El titular del dominio: Naturgy Energy Group, S.A
- Naturgy usa un proveedor externor para gestionar dominios: EURODNS S.A 
- Fecha de alta: 23-12-2016
- Fecha caducidad: 23-12-2026

Infraestructura técnica: 

Servidores DNS:

- akam.net → Akamai (CDN)
- ns3.naturgy.eu → infraestructura propia

Con el Akamai CDN puedo interpretar que Naturgy utiliza CDN para su protección, el rendimiento y la distribución del contenido 

Como dato curioso es que en la web española de WHOIS aparece como que la información de contacto está parcialmente protegida debido a políticas de privacidad.



#pagebreak()

=== RDAP
#v(0.2cm)

RDAP es un protocolo moderno y seguro que sustituye a WHOIS para poder consultar datos de registro de dominios, direcciones IP y ASN.

@corneo2024whois RDAP

Intenté obtener información mediante RDAP, pero no obtuve nada relevante, por lo que he preferido continuar con el análisis mediante RIPE Database.

=== RIPE:
#v(0.2cm)

RIPE es uno de los cinco registros regionales de internet (RIR) del mundo, se encarga de gestionar y asignar direcciones IPv4/IPv6 y números ASN en Europa. Como dato es una organización sin fines de lucro.

@staff2015ripe RIPE
#v(0.2cm)
Para buscar información sobre la empresa que estamos analizando nos vamos a la RIPE Database:

#align(center)[
  #image("imagenes/RIPE.png", width: 60%)
  
]
#v(0.2cm)

En ella encontramos la infraestructura de red a la que se asocia Naturgy.

He podido identificar que la organización utiliza infraestructura proporcionada por TELEFONICA DE ESPAÑA S.A.U.

Además, la web me proporciona muchos rangos de IP que están asignados a Naturgy como:

- 195.57.128.80 - 195.57.128.87
- 195.76.94.176 - 195.76.94.183

Con todos los rangos de IP que he obtenido me da indicios que tienen una infraestructura propia de gran tamaño.

También pude obtener que dicha infraestructura se encuentra localizada en España.

#pagebreak()

=== Shodan
#v(0.2cm)

Shodan es un motor de búsqueda de dispositivos conectados a internet. Permite localizar infraestruturas expuestas sin interactuar directamente con ella, indexando hasta puertos abiertos y vulnerabilidades.

La principal fortaleza radica en indexar no solo las páginas web, sino banners de servicios, puertos abiertos y metadatos de dispositivos que estén conectados a internet.

@mulero2023detection SHODAN
#v(0.2cm)

En este caso he utilizado Shodan para identificar servicios accesibles desde internet asociados a Naturgy:

#align(center)[
  #image("imagenes/shodan.jpg", width: 60%)
  
]
En estos primeros casos puse "naturgy.es", en el primero de los casos he identificado servidores web que sería "login.net.gasnaturalfenosa.com" y este está asociado a la IP 195.77.63.110

Ambos utilizan un servidor web Apache, utilizan protocolos HTTPS y certificados TLS 1.2 y TLS 1.3

En el segundo caso, se identifica un entorno de preproducción como: "login.preproduccion.net.gasnaturalfenosa.com".

Ambos están asociados a la organización de "NATURGY ENERGY GROUP"

Como dato curioso y se observa que ambos son de "Gas Natural Fenosa". Así es como se llama anteriormente Naturgy.
#v(0.4cm)

Segundo caso:
#v(0.4cm)


#align(center)[
  #image("imagenes/shodan2.jpg", width: 60%)
  
]

#v(0.4cm)
Al poner Naturgy a secas, salían algunas empresas españolas, pero el problema principal es que no estoy seguro de que estén asociadas a Naturgy. Además, salía otras empresas por el mundo como en Brasil o México.

#pagebreak()

=== TheHarvester
#v(0.2cm)

TheHarvester es una herramienta de código abierto basada en Pyhton, está diseñada para el reconocimiento pasivo, recopila inteligencia de fuentes abiertas, lo que realmente hace es automatizar la búsqueda de correos electrónicos, subdominios, hosts, nombres de empleados y direcciones IP, utilizando motores de búsqueda como Google, Bing, Yahoo y también utiliza plataformas/herramientas como shodan.

Básicamente, te hace el trabajo sucio, te resuelve las búsquedas de todo en un par de minutos o dependiendo de lo grande que sea la empresa y la mucha información expuesta que tengan, al ser automático el trabajo se vuelve más liviano y puedes analizar información de forma más exacta.

@estefania.dominguez_theharvester_2026 THEHARVESTER

#v(0.2cm)
He utilizado la herramienta para poder obtener información pública como subdominios, direcciones IP, URLs y otros datos relacionados con la infraestructura de la empresa.

Como se ve en la imagen he encontrado lo siguiente:


#align(center)[
  #image("imagenes/theHarvester.jpg", width: 60%)
  
]
Como se puede ver se han encontrado 165 hosts o subdominios, 59 IPs distintas y comentan como 59 URLs distintas.

Ahora veremos poco a poco información no pondré todo porque me parece excesivo:

Primera imagen:
#v(0.2cm)

#align(center)[
  #image("imagenes/theHarvester2.jpg", width: 80%)
  
]

Por ejemplo en esta imagen no salía en el resumen que existían 12 ASNs. El ASN es un identificador numérico único asignado a un grupo de redes Ip gestionadas por una sola organización.
#v(0.2cm)

Luego el otro apartado es de URLs interesantes, pues hay uno que me llamó la atención (como he comentado anteriormente es imposible entrar en todos).

El que me llamó la atención fue está "https://info.naturgy.es/portals/engine/1092/;jsessionid=2CB0DBDD6DA2CB19716E02E7581DE04C", como se aprecia hay un "jsessionid" en la URL, esto indica el uso de URL rewriting para la gestión de sesiones.

Esto no es recomendable, ya que los identifiacdores de sesión podrían estar expuestos en los logs.

#pagebreak()

Segunda imagen:

#align(center)[
  #image("imagenes/theHarvester3.jpg", width: 80%)
  
]

En la siguiente imagen tenemos todas las IPs que están expuestas:

Algunas de ellas son:

- 151.101.3.10
- 34.254.219.172
- 52.209.150.145

Esto me sugiere que ellos utilizan infraestructura cloud y redes de distribución de contenido (CDN), posiblemente mendiante proveedores como AWS, Akamai o Cloudflare para mejorar disponibilidad y rendimiento.
#v(0.2cm)

Tercera imagen:

#align(center)[
  #image("imagenes/theHarvester4.jpg", width: 80%)
  
]

En esta última imagen se puede mostrar alguno de los hosts o subdominios que presenta la empresa.

Algunos de estos ejemplos son:

- areaprivada.naturgy.es
- clientes.naturgy.es
- mail.naturgy.es
- solar.naturgy.es
- info.naturgy.es

Esto me indica que utilizan múltiples servicios web separados por subdominios para diferentes funcionalidades como clientes, facturación o correo.

Al tener esta gran cantidad de subdominios aumenta la superficie de exposición potencial, aunque no implica vulnerabilidades. Esta información podría utilizarse para descubrir puntos de acceso público.

#pagebreak()

=== Google Dorking:
#v(0.2cm)
Es conocido como Google Hacking también, es una técnica de búsqueda avanzada que utiliza operaciones especiales de Google para encontrar información específica.

@abasi2020google Google Dorking

#v(0.2cm)

He utilizado tres declaraciones:

Primera declaración "site:naturgy.es filetype:pdf":

#align(center)[
  #image("imagenes/GoogleDorking.jpg", width: 70%)
  
]

En este encuentra documentos públicos en este caso "pdf".

Hay algunos en los que no lo encuentra, pero se quedó reflejado, como en el segundo documento:

#align(center)[
  #image("imagenes/GoogleDorking2.jpg", width: 70%)
  
]



#pagebreak()
Segunda declaración "site:naturgy.es inurl:login":

#align(center)[
  #image("imagenes/GoogleDorking3.jpg", width: 70%)
  
]

Esta declaración busca páginas de autenticación.

En este caso no encontré nada, por lo que me indica que la empresa protege adecuadamente sus portales de autenticación evitando que sean fácilmente indexados por búsquedas.
#v(0.2cm)


Tercera declaración "site:naturgy.es filetype:xlsx OR filetype:docx":

#align(center)[
  #image("imagenes/GoogleDorking4.jpg", width: 70%)
  
]
#v(0.2cm)

Está declaración busca documentos Office que estén expuestos.

En este caso tampoco encontré nada, por lo que me indica que tienen una buena práctica de gestión documental, evitando la exposición accidental de información potencialmente sensible.


#pagebreak()
=== Google Hacking Database
#v(0.2cm)

Es una base de datos indexada que recopila miles de consultas de búsqueda avanzadas, es una evolución de lo anterior, esto está diseñado para encontrar información sensible expuesta. 

#v(0.2cm)

En este caso lo he utilizado para buscar posibles vulnerabilidades o información sensible expuesta mediante los dorks conocidos:

#align(center)[
  #image("imagenes/GoogleHackingDataBase.jpg", width: 70%)
  
]

Como se ve en la imagen no me salió información. La ausencia de resultados me indica que Naturgy no expone información sensible fácilmente indexable.

#v(0.2cm)

=== Way Back Machine

Es una biblioteca digital que funciona como una "máquina del tiempo", permite visualizar versiones anteriores.

He utilizado esta herramienta para analizar la evolución histórica del sitio web y estudiar la presencial digital de la compañía a lo largo del tiempo.

#align(center)[
  #image("imagenes/waybackmachine.jpg", width: 70%)
  
]

#v(0.2cm)

Como se ve en la imagen los primeros inicios vienen del año 2018, esto coincide con el cambio de marca de la empresa, que anteriormente operaba bajo el nombre de "Gas Natural Fenosa" y justo en ese año realizó el proceso de rebranding adoptando el nombre de Naturgy.


#pagebreak()


=== Redes sociales
En este caso he investigado la presencia digital de Naturgy en diferentes redes sociales para analizar su visibilidad pública y su estrategia de comunicación online:

#align(center)[
  #image("imagenes/RedesSociales.jpg", width: 40%)
  #image("imagenes/RedesSociales2.jpg", width: 40%)
  #image("imagenes/RedesSociales3.jpg", width: 40%)
  #image("imagenes/RedesSociales4.jpg", width: 40%)
  
]

La presencia en estas plataformas indica una estrategia activa de comunicación digital donde la empresa publica información tipo noticias, campañas publicitarias y contenido relacionado con energía y sosteniblidad.



#pagebreak()

=== Censys
#v(0.2cm)

 Es un motor de búsqueda que escanea continuamente la red global para mapear, identificar y analizar dispositivos, servidores, certificados y servicios expuestos en Internet.

 @noauthor_censys:_2016 CENSYS

Lo he utilizado para identificar hosts, certificados digitales y servicios expuestos.

Entonces aquí es lo que he encontrado:
#v(0.5cm)



#align(center)[
  #image("imagenes/censys.jpg", width: 100%)
  #v(0.2cm)
  #pagebreak()

  #image("imagenes/censys2.jpg", width: 30%)
]

En la segunda foto he encontrado información que me resultó interesante.

Identifiqué un host asociado a Naturgy: 82.194.91.81

Hostname: hs-1799.servidores-dedicados.es

Dominio relacionado: asluzygas-naturgy.es

Tiene de infraestructura un servidor que pertenece al proveedor de ACENS, que es una empresa española de hosting, que su ubicación es en Madrid (España).

También tienen servicios expuestos:

Servicios web:

- HTTP (80)
- HTTPS (443)
- HTTP alternativo (8443)

Servicios de correo:

- SMTP (25,465)
- POP3 (110,995)
- IMAP (143, 993)

Servicios de DNS:

Puerto 53

Luego destaca tecnologías como Postfix, Dovecot estás dos son de correo y luego Nginx que es web y Plesk (es un panel administrativo)

#pagebreak()


= Conclusiones
#v(0.3cm)

El análisis OSINT que he realizado sobre la empresa de Naturgy me permite observar que tienen una amplia presencia digital y una infraestructura tecnológica distribuida y profesionalizada.

Gracias a las herramientas como Whois, RIPE, Shodan, TheHarvester o Censys me han servido para poder identificar servicios web, servidores de correo, subdominios y alguna tecnología.

He podido comprobar que disponían proveedores de hosting y cloud, así como la existencia de infraestructura que se localiza España, lo que me permitió identificar su huella digital geográfica.

He podido comprobar la presencia activa de la organización en las redes sociales en las que forman parte de una estrategia clara de comunicación digital.

Me he dado cuenta de que TheHarvester es la herramienta que más información me dio, o por lo menos de forma concreta y clara. He podido descubrir subdominios y servicios asociados al dominio principal. 

Pero la gracia es que gracias a Shodan o Censys pude detectar hosts, direcciones IP, servicios expuestos y tecnologías utilizadas, como servidores web y paneles de administración, es cierto que con TheHarvester también he podido obtener algo similar.

Tras ver y analizar toda la empresa me he dado cuenta de que tras este trabajo he podido demostrarme toda la información pública que puede ser utilizada para entender todo lo extenso que es una organización, lo que resulta clave para los malos y para los buenos, haciendo atender que así se puede proteger las cosas desprotegidas.

En conjunto, este análisis demuestra como mediante fuentes abiertas es posible obtener una visión general y no tan general de la superficie de exposición de cualquier empresa.

#pagebreak()

#bibliography("bibliografia.bib")
