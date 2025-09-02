# Taller-Primer-Corte-Doing-Economics-2025-II
Este grupo de Haciendo Economia está conformado por Samuel Blanco Castellanos, Joan Schick, Juan Rusinque y Alejandro Herrera.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
Este repositorio contiene:

1. El primer trabajo realizado en clase, con la base de datos “Encuesta Tenderos" (https://research-data.urosario.edu.co/file.xhtml?persistentId=doi:10.34848/JLP6C3/LYTD5L&version=2.0) que se encuentra subida en Rawdata como "Base_de_datos_encuesta" (puede descargarse del repositorio: https://research-data.urosario.edu.co/dataset.xhtml?persistentId=doi:10.34848/JLP6C3). En este se buscaba seleccionar variables de interes para solucionar una pregunta problema y realizar graficos en R o stata.

2. Las tareas (1-5) correspondientes al uso de reshape, merge, collapse en Stata, con la construcción de bases transformadas a partir de la base de tenderos y la base de datos del DANE de terridata para el dato de población.

3. La visualización de datos a partir de graficos en Power BI. Cabe aclarar que en este caso no se replicaron exactamente las mismas graficas del primer ejercicio en el tablero de Power Bi pues encontramos graficas interesantes que pudimos construir a partir de las tablas del segundo ejercicio.

El trabajo es completamente reproducible y los productos del mismo se encuentran en este repositorio. El entregable final es el codigo en stata, las bases creadas que se encuentran en las carpetas de "Output" y "Created data", junto con el tablero de visualización en Power BI y todo se encuentra sintetizado en la presetación final en la carpeta "slides".
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
***Primer acercamiento:***
**¿Cómo se conectan los micronegocios con el sector financiero?**

Para responder esta pregunta se empleó la base de datos "Base_de_datos_encuesta". Con este material, se analizaron las respuestas a las preguntas 503, 504, 505, 506 y 507 de la Encuesta de Emprendimiento (WP1-2023-001), disponible en el repositorio: https://research-data.urosario.edu.co/dataset.xhtml?persistentId=doi:10.34848/JLP6C3 .

El objetivo fue identificar si los tenderos habían accedido a un crédito en los últimos 12 meses; en caso negativo, conocer las razones por las que no lo hicieron; y, en caso afirmativo, determinar a través de qué institución lo obtuvieron (banco, amigos, familiares o prestamistas particulares conocidos como “gota a gota”). 

***Segundo acercamiento:***
En nuestro segundo trabajo, el objetivo es que la empresa pueda responder una pregunta clave: "¿En qué zonas se registra una mayor penetración de internet que permita implementar un servicio orientado al fortalecimiento de las microempresas?"
A partir de esta pregunta principal, se pueden dividir tareas específicas que permitan realizar un análisis utilizando la base de datos Encuesta Emprendimiento Seguimiento Final. Esta base nos ayuda a identificar qué ciudades tienen una mayor población de microempresas que utilizan internet, lo que a su vez permite extraer los siguientes datos

  -¿Cuáles sectores comerciales son los que más usan internet?
  
  -¿Cuáles sectores comerciales son los que más usan internet por ciudad?
  
  -¿Determinar si existe una relación entre la penetración de internet en los negocios y la población de cada ciudad?

Para responder cada una de estas preguntas, utilizamos el software Stata, que nos permitió procesar, filtrar y analizar los datos de manera eficiente, facilitando la obtención de resultados precisos y relevantes para la toma de decisiones empresariales.

***Tercer acercamiento:***  **Taller Power BI**

Para este tercer trabajo se utilizó el software Power Bi con el objetivo de facilitar la visualización de datos relacionados con el uso del internet por parte de distintas entidades comerciales a nivel nacional. 

Para ello se construyeron diferentes gráficos y mapas que permiten comprender de manera más clara información: en primer lugar, se encuentra un diagrama de barras que muestra los principales sectores económicos en cada ciudad; en segundo lugar, un diagrama circular que evidencia la proporción de locales que cuentan con el servicio de internet; en tercer lugar , un treemap que clasifica los principales usos del internet en las diversas actividades económicas; y finalmente, un mapa  por municipio que refleja  la densidad de comercios conectados. 

Dicho paquete de ilustraciones es de utilidad para hacedores de política pública e instituciones encargadas de prestar el servicio de internet, puesto que ofrece evidencia clara sobre la desigualdad en el acceso y uso de la conectividad en los distintos sectores y ciudades. 

