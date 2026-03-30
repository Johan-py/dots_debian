# Bypasses básicos

En la sección anterior, vimos varios tipos de ataques que podemos usar para diferentes tipos de vulnerabilidades LFI. En muchos casos, es posible que nos enfrentemos a una aplicación web que aplica varias protecciones contra la inclusión de archivos, por lo que nuestras cargas útiles LFI normales no funcionarían. Aún así, a menos que la aplicación web esté adecuadamente protegida contra entradas maliciosas de usuarios de LFI, es posible que podamos eludir las protecciones existentes y lograr la inclusión de archivos.

---

## Filtros de recorrido de ruta no recursivos

Uno de los filtros más básicos contra LFI es un filtro de búsqueda y reemplazo, donde simplemente elimina subcadenas de (`../`) para evitar recorridos por caminos. Por ejemplo:

        php
`$language = str_replace('../', '', $_GET['language']);`

Se supone que el código anterior evita el cruce de rutas y, por lo tanto, hace que LFI sea inútil. Si probamos las cargas útiles LFI que probamos en la sección anterior, obtenemos lo siguiente:

http://<SERVER_IP>:<PORT>/index.php?language=../../../../etc/passwd

![Los contenedores y grúas de envío en un puerto con PHP incluyen mensajes de error mostrados.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/lfi_blacklist.png)

Vemos que todo `../` Se eliminaron las subcadenas, lo que dio como resultado una ruta final `./languages/etc/passwd`. Sin embargo, este filtro es muy inseguro, ya que no lo es `recursively removing` el `../` subcadena, ya que se ejecuta una sola vez en la cadena de entrada y no aplica el filtro en la cadena de salida. Por ejemplo, si usamos `....//` como nuestra carga útil, entonces el filtro se eliminaría `../` y la cadena de salida sería `../`, lo que significa que aún podemos realizar un recorrido de ruta. Intentemos aplicar esta lógica para incluir `/etc/passwd` din nou:

http://<SERVER_IP>:<PORT>/index.php?language=....//....//....//....//etc/passwd

![Contenedores de envío y grúas en un puerto con una lista de cuentas de usuario del sistema mostradas.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/lfi_blacklist_passwd.png)

Como podemos ver, la inclusión fue exitosa esta vez y podemos leer `/etc/passwd` con éxito. El `....//` La subcadena no es el único bypass que podemos usar, ya que podemos usar `..././` o `....\/` y varias otras cargas útiles LFI recursivas. Además, en algunos casos, escapar del carácter de barra diagonal también puede funcionar para evitar filtros de recorrido de ruta (por ejemplo, `....\/`), o agregar barras diagonales adicionales (p. ej. `....////`)

---

## Codificación

Algunos filtros web pueden impedir filtros de entrada que incluyan ciertos caracteres relacionados con LFI, como un punto `.` o una barra `/` Se utiliza para recorrer caminos. Sin embargo, algunos de estos filtros pueden omitirse codificando la URL de nuestra entrada, de modo que ya no incluiría estos caracteres incorrectos, pero aún así se decodificaría nuevamente en nuestra cadena de recorrido de ruta una vez que llegue a la función vulnerable. Los filtros PHP principales en las versiones 5.3.4 y anteriores eran específicamente vulnerables a esta omisión, pero incluso en versiones más nuevas podemos encontrar filtros personalizados que pueden omitirse mediante la codificación de URL.

Si la aplicación web de destino no lo permitió `.` y `/` En nuestra entrada, podemos codificar la URL `../` en `%2e%2e%2f`, que puede eludir el filtro. Para ello, podemos utilizar cualquier utilidad de codificador de URL en línea o utilizar la herramienta Burp Suite Decoder, de la siguiente manera:![código_url_burp](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/burp_url_encode.jpg)

**Nota:** Para que esto funcione debemos codificar en URL todos los caracteres, incluidos los puntos. Es posible que algunos codificadores de URL no codifiquen puntos, ya que se consideran parte del esquema de URL.

Intentemos utilizar esta carga útil LFI codificada contra nuestra aplicación web vulnerable anterior que filtra `../` cadenas:

<SERVER_IP>:<PORT>/index.php?longitud=%2e%2e%2f%2e%2e%2f%2e%2e%2f%2e%2e%2f%65%74%63%2f%70%61%73%73%77%64

![Burp Suite Decoder muestra la entrada de recorrido de ruta '../../etc/passwd' y su salida codificada en URL.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/lfi_blacklist_passwd_filter.png)

Como podemos ver, también pudimos eludir con éxito el filtro y utilizar el recorrido de ruta para leer `/etc/passwd`. Además, también podemos usar Burp Decoder para codificar la cadena codificada una vez más para tener una `double encoded` cadena, que también puede omitir otros tipos de filtros.

Puede consultar el [Inyecciones de comandos](https://academy.hackthebox.com/app/module/109) módulo para obtener más información sobre cómo omitir varios caracteres incluidos en la lista negra, ya que también se pueden usar las mismas técnicas con LFI.

---

## Caminos aprobados

Algunas aplicaciones web también pueden utilizar expresiones regulares para garantizar que el archivo que se incluye esté bajo una ruta específica. Por ejemplo, es posible que la aplicación web con la que hemos estado tratando solo acepte rutas que estén bajo el `./languages` directorio, de la siguiente manera:

        php
`if(preg_match('/^\.\/languages\/.+$/', $_GET['language'])) {     include($_GET['language']); } else {     echo 'Illegal path specified!'; }`

Para encontrar la ruta aprobada, podemos examinar las solicitudes enviadas por los formularios existentes y ver qué ruta utilizan para la funcionalidad web normal. Además, podemos difuminar directorios web bajo la misma ruta y probar otros diferentes hasta obtener una coincidencia. Para evitar esto, podemos usar el recorrido de ruta e iniciar nuestra carga útil con la ruta aprobada y luego usarla `../` Para volver al directorio raíz y leer el archivo especificamos lo siguiente:

<SERVER_IP>:<PORT>/index.php?idioma=./idiomas/../../../../etc/contraseña

![Contenedores de envío y grúas en un puerto con una lista de cuentas de usuario del sistema mostradas.](https://cdn.services-k8s.prod.aws.htb.systems/content/modules/23/lfi_blacklist_passwd_filter.png)

Algunas aplicaciones web pueden aplicar este filtro junto con uno de los filtros anteriores, por lo que podemos combinar ambas técnicas iniciando nuestra carga útil con la ruta aprobada y luego codificar la URL de nuestra carga útil o usar una carga útil recursiva.

**Nota:** Todas las técnicas mencionadas hasta ahora deberían funcionar con cualquier vulnerabilidad LFI, independientemente del lenguaje o marco de desarrollo back-end.

---

## Extensión adjunta

Como se discutió en la sección anterior, algunas aplicaciones web agregan una extensión a nuestra cadena de entrada (por ejemplo: `.php`), para garantizar que el archivo que incluimos esté en la extensión esperada. Con las versiones modernas de PHP, es posible que no podamos evitar esto y estaremos restringidos a leer solo archivos en esa extensión, lo que aún puede ser útil, como veremos en la siguiente sección (por ejemplo, para leer el código fuente).

Hay un par de técnicas más que podemos utilizar, pero lo son `obsolete with modern versions of PHP and only work with PHP versions before 5.3/5.4`. Sin embargo, aún puede ser beneficioso mencionarlos, ya que algunas aplicaciones web aún pueden estar ejecutándose en servidores más antiguos y estas técnicas pueden ser las únicas excepciones posibles.

#### Truncamiento de ruta

En versiones anteriores de PHP, las cadenas definidas tienen una longitud máxima de 4096 caracteres, probablemente debido a la limitación de los sistemas de 32 bits. Si se pasa una cadena más larga, simplemente será `truncated`, y cualquier carácter después de la longitud máxima será ignorado. Además, PHP también se utiliza para eliminar barras diagonales finales y puntos individuales en los nombres de rutas, por lo que si llamamos (`/etc/passwd/.`) entonces el `/.` también se truncaría y PHP llamaría (`/etc/passwd`). Los sistemas PHP y Linux en general también ignoran múltiples barras en la ruta (por ejemplo `////etc/passwd` es lo mismo que `/etc/passwd`). De manera similar, un acceso directo al directorio actual (`.`) en medio del camino también se ignoraría (por ejemplo. `/etc/./passwd`).

Si combinamos ambas limitaciones de PHP, podemos crear cadenas muy largas que evalúen una ruta correcta. Siempre que alcancemos la limitación de 4096 caracteres, la extensión adjunta (`.php`) se truncaría y tendríamos una ruta sin una extensión adjunta. Por último, también es importante señalar que también necesitaríamos hacerlo `start the path with a non-existing directory` para que esta técnica funcione.

Un ejemplo de dicha carga útil sería el siguiente:

        url
`?language=non_existing_directory/../../../etc/passwd/./././././ REPEATED ~2048 times]`

Por supuesto, no tenemos que escribir manualmente `./` 2048 veces (un total de 4096 caracteres), pero podemos automatizar la creación de esta cadena con el siguiente comando:

        shellsession
`DatalionPy@htb[/htb]$ echo -n "non_existing_directory/../../../etc/passwd/" && for i in {1..2048}; do echo -n "./"; done non_existing_directory/../../../etc/passwd/./././<SNIP>././././`

También podemos aumentar el recuento de `../`, ya que agregar más aún nos llevaría al directorio raíz, como se explicó en la sección anterior. Sin embargo, si utilizamos este método, debemos calcular la longitud total de la cadena para garantizar únicamente `.php` se trunca y no nuestro archivo solicitado al final de la cadena (`/etc/passwd`). Por eso sería más fácil utilizar el primer método.

#### Bytes nulos

Las versiones de PHP anteriores a la 5.5 eran vulnerables a `null byte injection`, lo que significa que agregar un byte nulo (`%00`) al final de la cadena terminaría la cadena y no consideraría nada después de ella. Esto se debe a cómo se almacenan las cadenas en la memoria de bajo nivel, donde las cadenas en la memoria deben usar un byte nulo para indicar el final de la cadena, como se ve en los lenguajes Assembly, C o C++.

Para explotar esta vulnerabilidad, podemos finalizar nuestra carga útil con un byte nulo (por ejemplo. `/etc/passwd%00`), de modo que el camino final pasara a `include()` sería (`/etc/passwd%00.php`). De esta manera, aunque `.php` se agrega a nuestra cadena, cualquier cosa después del byte nulo se truncaría, por lo que la ruta utilizada en realidad sería `/etc/passwd`, lo que nos lleva a omitir la extensión adjunta.