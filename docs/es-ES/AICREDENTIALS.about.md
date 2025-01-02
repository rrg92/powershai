# Ai Credentials 


# Introducción <!--! @#Short --> 

AI Credentials es un mecanismo de powershai que permite configurar credenciales y tokens de acceso a las APIs de los proveedores 

# Detalles  <!--! @#Long --> 

La mayoría de los proveedores disponibles en powershai requieren algún tipo de autenticación.  
Ya sea a través de API Token, JWT, oauth, etc., puede ser necesario proporcionar algún tipo de credencial.

Las primeras versiones de Powershai dejaban libre a cada proveedor implementar sus propios comandos de autenticación.  
Pero, dado que este es un proceso común a casi todos los proveedores, entendimos que era importante estandarizar la forma en que se crean y acceden estas credenciales.
Así, los usuarios tienen una forma estándar de autenticarse, utilizando siempre los mismos comandos, lo que es más fácil, incluso para obtener ayuda.

Con esto, nace el AI Credentials: Un mecanismo estándar de powershai para gestionar las credenciales de los proveedores.  

## Definiendo credenciales 

Para crear una nueva credencial, usa Set-AiCredential:

```powershell 
Set-AiCredential
```

Set-AiCredential es un alias para el comando definitivo definido por el proveedor actual.
Cada proveedor puede proporcionar una implementación específica, que contiene su propio código y parámetros.  

El PowershAI gestiona a dónde apunta este alias, conforme se cambia el proveedor.  

El proveedor puede proporcionar parámetros adicionales, por lo que `Set-AiCredential` puede contener parámetros diferentes, dependiendo del proveedor.
Otra manera de definir credenciales es usando variables de entorno. Cada proveedor puede definir la lista de variables posibles.

Usa `get-help Set-AiCredential` o consulta la doc del proveedor para más detalles y orientaciones sobre cómo proporcionar los parámetros y variables de entorno.

Opcionalmente, puedes definir un nombre y descripción para la credencial, usando el parámetro `-Name` `-Description`.  
Si no se especifica un nombre, se usará un nombre por defecto.  

Si ya existe una credencial con el mismo nombre, preguntará si deseas reemplazarla. Puedes usar -force para omitir la confirmación.  


## Usando credenciales 

Los proveedores interactúan con el AI Credentials a través del comando `Get-AiDefaultCredential`.  
Puedes usar el comando para verificar qué credencial será utilizada por el proveedor activo.  

Para evitar usar tokens incorrectos, powershai ahora tiene la estrategia de no usar una credencial si no hay una garantía de que es la intención del usuario usarla.

Basado en esto, este comando devuelve la credencial por defecto. Powershai define una credencial por defecto siguiendo estas reglas:

* Si existe solamente 1 credencial, esta es la por defecto 
* De lo contrario, el usuario debe definir explícitamente la por defecto usando Set-AiDefaultCredential

Las credenciales definidas a través de variables de entorno son tratadas como por defecto.  
Sin embargo, si se ha definido una credencial a través de una variable de entorno y existe una credencial definida como por defecto explícitamente, entonces powershai devuelve un error.<!--! 
Gracias a este mecanismo, todos los proveedores pueden, de manera estándar, obtener credenciales definidas por el usuario, bajo los mismos mecanismos de validación, manteniendo aún las diferencias de información que pueden ser necesarias. 
-->

<!--! 
Recuerda que para obtener más información y ayuda, puedes usar el comando Get-Help `Comando`. Los comandos del AiCredential tienden a contener muchos detalles de funcionamiento no documentados en este tema.
-->


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
