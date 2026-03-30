Muchos lenguajes back-end modernos, como `PHP`, `Javascript`, o `Java`, utiliza parámetros HTTP para especificar lo que se muestra en la página web, lo que permite crear páginas web dinámicas, reduce el tamaño general del script y simplifica el código. En tales casos, se utilizan parámetros para especificar qué recurso se muestra en la página. Si dichas funcionalidades no están codificadas de forma segura, un atacante puede manipular estos parámetros para mostrar el contenido de cualquier archivo local en el servidor de alojamiento, lo que genera un [Inclusión de archivos locales (LFI)](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion) vulnerabilidad.

## Inclusión de archivos locales (LFI = Local File Inclucion)

El lugar más común en el que solemos encontrar LFI son los motores de plantillas. Para que la mayor parte de la aplicación web tenga el mismo aspecto al navegar entre páginas, un motor de plantillas muestra una página que muestra las partes estáticas comunes, como la `header`, `navigation bar`, y `footer`, y luego carga dinámicamente otro contenido que cambia entre páginas. De lo contrario, sería necesario modificar cada página del servidor cuando se realicen cambios en cualquiera de las partes estáticas. Por eso a menudo vemos un parámetro como `/index.php?page=about`, donde `index.php` establece contenido estático (por ejemplo, encabezado/pie de página) y luego solo extrae el contenido dinámico especificado en el parámetro, que en este caso puede leerse desde un archivo llamado `about.php`. Como tenemos control sobre el `about`Como parte de la solicitud, es posible que la aplicación web tome otros archivos y los muestre en la página.

Las vulnerabilidades de LFI pueden provocar la divulgación del código fuente, la exposición de datos confidenciales e incluso la ejecución remota de código bajo ciertas condiciones. La filtración del código fuente puede permitir a los atacantes probar el código en busca de otras vulnerabilidades, que pueden revelar vulnerabilidades previamente desconocidas. Además, la filtración de datos confidenciales puede permitir a los atacantes enumerar el servidor remoto en busca de otras debilidades o incluso filtrar credenciales y claves que pueden permitirles acceder al servidor remoto directamente. Bajo condiciones específicas, LFI también puede permitir a los atacantes ejecutar código en el servidor remoto, lo que puede comprometer todo el servidor back-end y cualquier otro servidor conectado a él.

---

## Ejemplos de código vulnerable

Veamos algunos ejemplos de código vulnerable a la inclusión de archivos para comprender cómo ocurren dichas vulnerabilidades. Como se mencionó anteriormente, pueden ocurrir vulnerabilidades de inclusión de archivos en muchos de los servidores web y marcos de desarrollo más populares, como `PHP`, `NodeJS`, `Java`, `.Net`, y muchos otros. Cada uno de ellos tiene un enfoque ligeramente diferente para incluir archivos locales, pero todos comparten una cosa común: cargar un archivo desde una ruta específica.

Un archivo de este tipo podría ser un encabezado dinámico o un contenido diferente según el idioma especificado por el usuario. Por ejemplo, la página puede tener un `?language` Parámetro GET, y si un usuario cambia el idioma desde un menú desplegable, se devolverá la misma página pero con una diferente `language` parámetro (por ejemplo `?language=es`). En tales casos, cambiar el idioma puede cambiar el directorio desde el que la aplicación web carga las páginas (por ejemplo: `/en/` o `/es/`). Si tenemos control sobre la ruta que se está cargando, entonces podremos aprovechar esta vulnerabilidad para leer otros archivos y potencialmente alcanzar la ejecución remota de código.

#### PHP

En `PHP`, podemos usar el `include()` función para cargar un archivo local o remoto mientras cargamos una página. Si el `path` pasado al `include()` se toma de un parámetro controlado por el usuario, como un `GET` parámetro, y `the code does not explicitly filter and sanitize the user input`, entonces el código se vuelve vulnerable a la inclusión de archivos. El siguiente fragmento de código muestra un ejemplo de ello:

        php
`if (isset($_GET['language'])) {     include($_GET['language']); }`

Vemos que el `language` El parámetro se pasa directamente al `include()` función. Entonces, cualquier camino que pasemos en el `language` El parámetro se cargará en la página, incluidos los archivos locales en el servidor back-end. Esto no es exclusivo de la `include()` función, ya que hay muchas otras funciones PHP que conducirían a la misma vulnerabilidad si tuviéramos control sobre la ruta que se pasa a ellas. Estas funciones incluyen: `include_once()`, `require()`, `require_once()`, `file_get_contents()`, y varios otros también.

**Nota:** En este módulo, nos centraremos principalmente en aplicaciones web PHP que se ejecutan en un servidor back-end Linux. Sin embargo, la mayoría de las técnicas y ataques funcionarían en la mayoría de los demás marcos, por lo que nuestros ejemplos serían los mismos con una aplicación web escrita en cualquier otro lenguaje.

#### NodeJS

Al igual que en el caso de PHP, los servidores web NodeJS también pueden cargar contenido en función de parámetros HTTP. El siguiente es un ejemplo básico de cómo funciona un parámetro GET `language` se utiliza para controlar qué datos se escriben en una página:

        javascript
`if(req.query.language) {     fs.readFile(path.join(__dirname, req.query.language), function (err, data) {        res.write(data);    }); }`

Como podemos ver, cualquier parámetro pasado desde la URL es utilizado por el `readfile` función que luego escribe el contenido del archivo en la respuesta HTTP. Otro ejemplo es el `render()` función en el `Express.js` estructura. El siguiente ejemplo muestra cómo `language` El parámetro se utiliza para determinar qué directorio extraer `about.html` página de:

        js
``app.get("/about/:language", function(req, res) {     res.render(`/${req.params.language}/about.html`); });``

A diferencia de nuestros ejemplos anteriores donde los parámetros GET se especificaron después de a (`?`) carácter en la URL, el ejemplo anterior toma el parámetro de la ruta de la URL (por ejemplo `/about/en` o `/about/es`). Como el parámetro se utiliza directamente dentro del `render()` función para especificar el archivo renderizado, podemos cambiar la URL para mostrar un archivo diferente.

#### Java

El mismo concepto se aplica a muchos otros servidores web. Los siguientes ejemplos muestran cómo las aplicaciones web para un servidor web Java pueden incluir archivos locales basados en el parámetro especificado, utilizando el `include` función:

        jsp
`<c:if test="${not empty param.language}">     <jsp:include file="<%= request.getParameter('language') %>" /> </c:if>`

El `include` La función puede tomar un archivo o la URL de una página como argumento y luego representar el objeto en la plantilla del front-end, similar a las que vimos anteriormente con NodeJS. El `import` La función también se puede utilizar para representar un archivo local o una URL, como en el siguiente ejemplo:

        jsp
`<c:import url= "<%= request.getParameter('language') %>"/>`

#### .NETO

Finalmente, tomemos un ejemplo de cómo pueden ocurrir vulnerabilidades de inclusión de archivos en .Aplicaciones web NET. El `Response.WriteFile` La función funciona de manera muy similar a todos nuestros ejemplos anteriores, ya que toma una ruta de archivo para su entrada y escribe su contenido en la respuesta. La ruta se puede recuperar desde un parámetro GET para la carga dinámica de contenido, de la siguiente manera:

        thu
`@if (!string.IsNullOrEmpty(HttpContext.Request.Query['language'])) {     <% Response.WriteFile("<% HttpContext.Request.Query['language'] %>"); %>  }`

Además, el `@Html.Partial()` La función también se puede utilizar para representar el archivo especificado como parte de la plantilla del front-end, de manera similar a lo que vimos anteriormente:

        thu
`@Html.Partial(HttpContext.Request.Query['language'])`

Finalmente, el `include` La función se puede utilizar para representar archivos locales o URL remotas, y también puede ejecutar los archivos especificados:

        thu
`<!--#include file="<% HttpContext.Request.Query['language'] %>"-->`

## Leer vs ejecutar

De todos los ejemplos anteriores, podemos ver que pueden ocurrir vulnerabilidades de inclusión de archivos en cualquier servidor web y en cualquier marco de desarrollo, ya que todos ellos proporcionan funcionalidades para cargar contenido dinámico y manejar plantillas front-end.

Lo más importante a tener en cuenta es que `some of the above functions only read the content of the specified files, while others also execute the specified files`. Además, algunos de ellos permiten especificar URL remotas, mientras que otros sólo funcionan con archivos locales del servidor back-end.

La siguiente tabla muestra qué funciones pueden ejecutar archivos y cuáles solo leen el contenido del archivo:

|**Función**|**Leer contenido**|**Ejecutar**|**URL remota**|
|---|:-:|:-:|:-:|
|**PHP**||||
|`include()`/`include_once()`|✅|✅|✅|
|`require()`/`require_once()`|✅|✅|❌|
|`file_get_contents()`|✅|❌|✅|
|`fopen()`/`file()`|✅|❌|❌|
|**NodeJS**||||
|`fs.readFile()`|✅|❌|❌|
|`fs.sendFile()`|✅|❌|❌|
|`res.render()`|✅|✅|❌|
|**Java**||||
|`include`|✅|❌|❌|
|`import`|✅|✅|✅|
|**.NETO**||||
|`@Html.Partial()`|✅|❌|❌|
|`@Html.RemotePartial()`|✅|❌|✅|
|`Response.WriteFile()`|✅|❌|❌|
|`include`|✅|✅|✅|

Esta es una diferencia significativa a tener en cuenta, ya que ejecutar archivos puede permitirnos ejecutar funciones y eventualmente conducir a la ejecución de código, mientras que leer solo el contenido del archivo solo nos permitiría leer el código fuente sin ejecutar código. Además, si tuviéramos acceso al código fuente en un ejercicio de caja blanca o en una auditoría de código, conocer estas acciones nos ayuda a identificar posibles vulnerabilidades de inclusión de archivos, especialmente si tenían entradas controladas por el usuario.

En todos los casos, las vulnerabilidades de inclusión de archivos son críticas y eventualmente pueden comprometer todo el servidor back-end. Incluso si solo pudiéramos leer el código fuente de la aplicación web, aún podría permitirnos comprometer la aplicación web, ya que puede revelar otras vulnerabilidades como se mencionó anteriormente, y el código fuente también puede contener claves de base de datos, credenciales de administrador u otra información confidencial.