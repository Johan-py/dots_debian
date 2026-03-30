# Inclusión de archivos locales (LFI)

Ahora que entendemos qué son las vulnerabilidades de inclusión de archivos y cómo ocurren, podemos comenzar a aprender cómo podemos explotar estas vulnerabilidades en diferentes escenarios para poder leer el contenido de los archivos locales en el servidor back-end.

---

## LFI básico

El ejercicio que tenemos al final de esta sección nos muestra un ejemplo de una aplicación web que permite a los usuarios configurar su idioma en inglés o español:

http://<SERVER_IP>:<PORT>/

![Página web que muestra 'Inlane Freight' con un menú desplegable de idioma abierto, que muestra opciones para 'inglés' y 'español'.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/basic_lfi_lang.png)

Si seleccionamos un idioma haciendo clic en él (por ejemplo `Spanish`), vemos que el texto del contenido cambia al español:

http://<SERVER_IP>:<PORT>/index.php?language=es.php

![Contenedores de envío apilados en un puerto con grúas al fondo, lo que ilustra la historia y la industria del transporte de contenedores.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/basic_lfi_es.png)

También observamos que la URL incluye a `language` parámetro que ahora está configurado en el idioma que seleccionamos (`es.php`). Hay varias formas de cambiar el contenido para que coincida con el idioma que especificamos. Es posible que se trate de extraer el contenido de una tabla de base de datos diferente en función del parámetro especificado o de cargar una versión completamente diferente de la aplicación web. Sin embargo, como se mencionó anteriormente, cargar parte de la página mediante motores de plantillas es el método más fácil y común utilizado.

Entonces, si la aplicación web realmente extrae un archivo que ahora se incluye en la página, es posible que podamos cambiar el archivo que se extrae para leer el contenido de un archivo local diferente. Dos archivos legibles comunes que están disponibles en la mayoría de los servidores backend son `/etc/passwd` en Linux y `C:\Windows\boot.ini` en Windows. Entonces, cambiemos el parámetro de `es` to `/etc/passwd`:

http://<SERVER_IP>:<PORT>/index.php?language=/etc/passwd

![Contenedores de envío y grúas en un puerto, con una lista de cuentas de usuario del sistema mostradas.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/basic_lfi_lang_passwd.png)

Como podemos ver, la página es realmente vulnerable y podemos leer el contenido de la misma `passwd` archivar e identificar qué usuarios existen en el servidor back-end.

---

## Travesía de ruta

En el ejemplo anterior, leemos un archivo especificando su `absolute path` (p. ej. `/etc/passwd`). Esto funcionaría si se utilizara toda la entrada dentro del `include()` función sin ninguna adición, como el siguiente ejemplo:

        php
`include($_GET['language']);`

En este caso, si intentamos leer `/etc/passwd`, entonces el `include()` La función recuperaría ese archivo directamente. Sin embargo, en muchas ocasiones, los desarrolladores web pueden agregar o anteponer una cadena al `language` parámetro. Por ejemplo, el `language` El parámetro se puede utilizar para el nombre del archivo y se puede agregar después de un directorio, de la siguiente manera:

        php
`include("./languages/" . $_GET['language']);`

En este caso, si intentamos leer `/etc/passwd`, entonces el camino pasó a `include()` sería (`./languages//etc/passwd`), y como este archivo no existe, no podremos leer nada:

http://<SERVER_IP>:<PORT>/index.php?language=/etc/passwd

![Los contenedores y grúas de envío en un puerto con PHP incluyen mensajes de error mostrados.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/traversal_passwd_failed.png)

Como era de esperar, el error detallado devuelto nos muestra la cadena pasada al `include()` función, indicando que no hay `/etc/passwd` en el directorio de idiomas.

**Nota:** Solo habilitamos errores PHP en esta aplicación web con fines educativos, para que podamos comprender adecuadamente cómo la aplicación web maneja nuestra entrada. En el caso de aplicaciones web de producción, estos errores nunca deben mostrarse. Además, todos nuestros ataques deberían ser posibles sin errores, ya que no dependen de ellos.

Podemos eludir fácilmente esta restricción recorriendo directorios usando `relative paths`. Para ello podemos añadir `../` antes de nuestro nombre de archivo, que hace referencia al directorio principal. Por ejemplo, si la ruta completa del directorio de idiomas es `/var/www/html/languages/`, luego usando `../index.php` se referiría a la `index.php` archivo en el directorio principal (es decir. `/var/www/html/index.php`).

Entonces, podemos usar este truco para retroceder varios directorios hasta llegar a la ruta raíz (es decir, `/`), y luego especifique nuestra ruta de archivo absoluta (por ejemplo. `../../../../etc/passwd`), y el archivo debería existir:

http://<SERVER_IP>:<PORT>/index.php?language=../../../../etc/passwd

![Contenedores de envío y grúas en un puerto con una lista de cuentas de usuario del sistema mostradas.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/traversal_passwd.png)

Como podemos ver, esta vez pudimos leer el archivo independientemente del directorio en el que estuviéramos. Este truco funcionaría incluso si se usara todo el parámetro en el `include()` función, por lo que podemos utilizar esta técnica de forma predeterminada y debería funcionar en ambos casos. Además, si estuviéramos en el camino raíz (`/`) y usado `../` entonces todavía permaneceríamos en el camino raíz. Entonces, si no estábamos seguros del directorio en el que se encuentra la aplicación web, podemos agregar `../` muchas veces, y no debería romper el camino (¡aunque lo hagamos cien veces!).

**Consejo:** Siempre puede ser útil ser eficiente y no añadir cosas innecesarias `../` varias veces, especialmente si estábamos escribiendo un informe o escribiendo un exploit. Entonces, intenta siempre encontrar el número mínimo de `../` eso funciona y úsalo. También puedes calcular cuántos directorios tienes lejos de la ruta raíz y usar esa cantidad. Por ejemplo, con `/var/www/html/` nosotros somos `3` directorios alejados de la ruta raíz, por lo que podemos usarlos `../` 3 veces (es decir. `../../../`).

---

## Prefijo de nombre de archivo

En nuestro ejemplo anterior, utilizamos el `language` parámetro después del directorio, por lo que podríamos recorrer la ruta para leer el `passwd` archivo. En algunas ocasiones, nuestra entrada puede agregarse después de una cadena diferente. Por ejemplo, se puede utilizar con un prefijo para obtener el nombre de archivo completo, como en el siguiente ejemplo:

        php
`include("lang_" . $_GET['language']);`

En este caso, si intentamos recorrer el directorio con `../../../etc/passwd`, la cadena final sería `lang_../../../etc/passwd`, lo cual no es válido:

http://<SERVER_IP>:<PORT>/index.php?language=../../../etc/passwd

![Los contenedores y grúas de envío en un puerto con PHP incluyen un mensaje de error mostrado.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/lfi_another_example1.png)

Como era de esperar, el error nos dice que este archivo no existe. Entonces, en lugar de usar directamente el recorrido de ruta, podemos anteponer un `/` antes de nuestra carga útil, y esto debería considerar el prefijo como un directorio, y luego deberíamos omitir el nombre del archivo y poder recorrer los directorios:

http://<SERVER_IP>:<PORT>/index.php?language=/../../../etc/passwd

![Contenedores de envío y grúas en un puerto con una lista de cuentas de usuario del sistema mostradas.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/lfi_another_example_passwd1.png)

**Nota:** Es posible que esto no siempre funcione, ya que en este ejemplo un directorio llamado `lang_/` Puede que no exista, por lo que nuestra ruta relativa puede no ser correcta. Además, `any prefix appended to our input may break some file inclusion techniques` Lo discutiremos en las próximas secciones, como el uso de contenedores y filtros PHP o RFI.

---

## Extensiones adjuntas

Otro ejemplo muy común es cuando se agrega una extensión al `language` parámetro, como sigue:

        php
`include($_GET['language'] . ".php");`

Esto es bastante común, ya que en este caso no tendríamos que escribir la extensión cada vez que necesitemos cambiar el idioma. Esto también puede ser más seguro ya que puede restringirnos a incluir únicamente archivos PHP. En este caso, si intentamos leer `/etc/passwd`, entonces el archivo incluido sería `/etc/passwd.php`, que no existe:

http://<SERVER_IP>:<PORT>/extension/index.php?language=/etc/passwd

![Los contenedores y grúas de envío en un puerto con PHP incluyen mensajes de error mostrados.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/lfi_extension_failed.png)

Hay varias técnicas que podemos utilizar para evitar esto y las analizaremos en las próximas secciones.

**Ejercicio:** Intente leer cualquier archivo php (por ejemplo, index.php) a través de LFI y vea si obtendrá su código fuente o si el archivo se representa como HTML.

---

## Ataques de segundo orden

Como podemos ver, los ataques LFI pueden presentarse en diferentes formas. Otro ataque LFI común y un poco más avanzado es un `Second Order Attack`. Esto ocurre porque muchas funcionalidades de aplicaciones web pueden extraer archivos del servidor back-end de forma insegura en función de parámetros controlados por el usuario.

Por ejemplo, una aplicación web puede permitirnos descargar nuestro avatar a través de una URL como (`/profile/$username/avatar.png`). Si creamos un nombre de usuario LFI malicioso (por ejemplo `../../../etc/passwd`), entonces es posible cambiar el archivo que se extrae a otro archivo local en el servidor y capturarlo en lugar de nuestro avatar.

En este caso, estaríamos envenenando una entrada de la base de datos con una carga útil LFI maliciosa en nuestro nombre de usuario. Luego, otra funcionalidad de la aplicación web utilizaría esta entrada envenenada para realizar nuestro ataque (es decir, descargar nuestro avatar según el valor del nombre de usuario). Por eso este ataque se llama a `Second-Order` attack.

Los desarrolladores a menudo pasan por alto estas vulnerabilidades, ya que pueden proteger contra la entrada directa del usuario (por ejemplo, desde un `?page` parámetro), pero pueden confiar en valores extraídos de su base de datos, como nuestro nombre de usuario en este caso. Si lográramos envenenar nuestro nombre de usuario durante nuestro registro, entonces el ataque sería posible.

La explotación de vulnerabilidades LFI mediante ataques de segundo orden es similar a lo que hemos analizado en esta sección. La única variación es que necesitamos detectar una función que extrae un archivo en función de un valor que controlamos indirectamente y luego intentar controlar ese valor para explotar la vulnerabilidad.

**Nota:** Todas las técnicas mencionadas en esta sección deben funcionar con cualquier vulnerabilidad LFI, independientemente del lenguaje o marco de desarrollo back-end.