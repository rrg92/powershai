---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSessionApiProxyFunction

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Crea funciones que encapsulan las llamadas a un endpoint de Gradio (o todos los endpoints).  
Este cmdlet es muy útil para crear funciones powershell que encapsulan un endpoint API de Gradio, donde los parámetros de la API son creados como parámetros de la función.  
Así, recursos nativos del powershell, como auto complete, tipo de datos y documentación, pueden ser usados y fica muy fácil invocar cualquier endpoint de una sesión.

El comando consulta los metadatos de los endpoints y parámetros y crea las funciones powershell en el ámbito global.  
Con eso, el usuario consigue invocar las funciones directamente, como si fueran funciones normal.  

Por ejemplo, suponga que una aplicación Gradio en la dirección http://mydemo1.hf.space tenga un endpoint llamado /GenerateImage para generar imágenes con el Stable Diffusion.  
Asuma que esa aplicación acepte 2 parámetros: Prompt (la descripción de la imagen a ser generada) y Steps (el número total de steps).

Normalmente, usted podría usar el comando Invoke-GradioSessionApi, así: 

$MySession = Get-GradioSession http://mydemo1.hf.space
$ApiEvent = $MySession | Invoke-GradioSessionApi -ApiName 'GenerateImage' -params "A car",100

Eso iría dar inicio a la API, y usted podría obtener los resultados usando Update-GradioApiResult:

$ApiEvent | Update-GradioApiResult

Con este cmdlet, usted consigue encapsular un poco más estas llamadas:

$MySession = Get-GradioSession http://mydemo1.hf.space
$MySession | New-GradioSessionApiProxyFunction

El comando arriba creará una función llamada Invoke-GradioApiGenerateimage.
Entonces, voc poe usar de manera simple para generar la imagen:

Invoke-GradioApiGenerateimage -Prompt "A car" -Steps 100 

Por defecto, el comando ejecutaría y ya iría obtener los eventos de resultados, escribiendo en el pipeline para que usted pueda integrar con otros comandos.  
Inclusive, conectar varios spaces es muy simple, vea abajo sobre pipeline.

NOMENCLATURA 

	El nombre de las funciones creadas sigue el formato:  <Prefix><NomeOp>
		<Prefix> es el valor del parámetro -Prefix de este cmdlet. 
		<NomeOp> es el nombre de la operación, mantenido solo letras y números
		
		Por ejemploi, si la operación es /Op1, y el Prefixo INvoke-GradioApi, la siguiente función será cread: Invoke-GradioApiOp1

	
PARAMETROS
	Las funciones creadas contienen la lógica necesaria para transformar los parámetros pasados y ejecutar el cmdlet Invoke-GradioSessionApi.  
	O sea, el mismo retorno se aplica como si estuviera invocando este cmdlet directamente.  (Esto es, un evento será retornado y adicionaod a lista de eventos de la sesión actual).
	
	Los parámetros de las funciones pueden variar conforme el endpoint de la API, pues cada endpoint posee un conjunto diferente de parámetros y tipos de datos.
	Parámetros que son archivos (o lista de archivos), poseen un paso adicional de upload. El archivo puede ser referenciado localmente y el upload dele sera hecho para el servidor.  
	Caso sea informado una URL, o un objeto FileData recibido de otro comando, ningún upload adicional será hecho, apenas será generado un objeto FileData correspondiente para envío via API.

	Además de los parámetros del endpoint, hay un conjunto adicional de parámetros que siempre serán añadidos a la función creada.  
	Son ellos:
		- Manual  
		Si usado, hace con que el cmdlet retorne el evento generado por INvoke-GradioSessionApi.  
		En este caso usted tendrá que manualmente obtener los resultados usando Update-GradioSessionApiResult
		
		- ApiResultMap 
		Mapeia los resultados de otros comandos para los parámetros. Veha más sobre en la sección PIPELINE.
		
		- DebugData
		Para fines de debug por los desarrolladores.
		
UPLOAD 	
	Parametros que aceptan archivos son tratados de una manera especial.  
	Antes de la invocacao de la API, el cmdlet Send-GradioSessionFiles esusado para hacer el upload de esos archivos para el respectivo app gradio.  
	Isso es una oura grande ventaja de se usar esse cmdlet, pois isso fica transparente, y el usuario no necesita lidiar con uploads.

PIPELINE 
	
	Una de las funcionalidades más poderosas del powershell es el pipeline, one es posible conectar varios comandos usando el pipe |.
	E este cmdlet procura también usurfruir al máximo de ese recurso.  
	
	Todas las funciones creadas pueden ser conectadas con el |.
	Al hacer eso, cada evento generado por el cmdlet anterior es pasado para el próximo.  
	
	Considere dos apps gradios, App1 y App2.
	App1 posee el endpoint Img, con un parametro llamado Text, que genera imágenes usando Diffusers, exibindo las parciais de cada imagen a medida que son generadas.
	App2 posee un endpoint Ascii, con un parametor llamado Image, que transforma una iamgem en una versión ascii en texto.
	
	Usted puede conectar estos dos comandos de una manera muy simpels con el pipeline.  
	Primero, cree las sesiones

		$App1 = New-GradioSession http://stable-diffusion
		$App2 = New-GradioSession http://ascii-generator
		
	Cree las funciones 
		$App1 | New-GradioSessionApiProxy -Prefix App # isso criar a funcao AppImg
		$App2 | New-GradioSessionApiProxy -Prefix App # isso criar a funcao AppAscii
		
	Gere la imagen y conecte con el gerador asciii :
	
	AppImg -Text "A car" | AppAscii -Map ImageInput=0 | %{  $_.data[0]; write-host $_.pipeline[0].data[0].url } 
	
	Ahora vamos quebrar la sequencia acima.
	
	Antes del primer pipe, tenemos el comando que genera la imagen: AppImg -Text "A car" 
	Esta función está llamado el endpoint /Img de App1. Este endpoint produce una saida para etapa de la geracao de imágenes con la lib Diffusers del hugging face.  
	En este caso, cada saida será una imagen (bien embaraçada), hasta la última saida que será la iamgem final.  
	Este resultado fica na proprodiade data del objeto del pipeline. Ella es un array con los resultados.
	
	Logo em seguida no pipe, tenemos el comando: AppAscii -Map ImageInput=0
	Este comando irá recber cada objeto generado por el comando AppImg, que no caso, son las imágenes parciais del proceso de difusion.  
	
	Debido al fato os comandos pueden generar una rray de saidas, é preciso mapear exactamente qual dos resultados devem ser associados com quais parametros.  
	Por isso, usamos el parametro -Map (-Map es un Alias, na verdade, el nombre correcto es ApiResultMap)
	La sintaxe es simple: NomeParam=DataIndex,NomeParam=DataIndex  
	No comando acima, estamos diciendo: AppAscii, utilize el primer valor de la proprodiade data en el parametro ImageInput.  
	Por ejemplo, se AppImg retornasse 4 valores, e imagen estivesse na ultima posicao, vc deveria usar ImageInput=3 (0 es la primera).
	
	
	Por fim, el ultiomo pipe apenas evole el resultado de AppAscii, que ahora se encontrano objeto del pipeline, $_, na proprodade .data (igual o resultado de AppImg).  
	E, para complementar, el objeto del pipeline posee una proprodade especial, llamada pipeline. Com ella, voce acessar todos los resultados de los comandos geraod.s  
	Por ejemplo, $_.pipeline[0], contém el resultado del primer comando (AppImg). 
	
	Graça a esse mecanismo, fica mucho más fácil conectar diferentes apps Gradio en unico pipeline.
	Note que esta sequencia funciona apenas entre comandos gerados por New-GradioSessionApiProxy. Fazer el pipe de otros comanos, não irá produzir esse mesmo efeito (terá qiue usar algo como el For-EachObject e associar los parametros directamente)


SESSOES 
	Cuando la función es creada, la sesión de origen es cravada junto con la función .  
	Si la sesión for removida, el cmdlet irá generar un erro. NEste caso, voce deve criar la función invocando este cmdlet nuevamente.  


El siguiente diagrama resume las dependencias envueltas:

	New-GradioSessionApiProxyFunction(Prefix)
		---> function <Prefix><OpName>
			---> Send-GradioSessionFiles (cuando houer archivos)
			---> Invoke-GradioSessionApi | Update-GradioSessionApiResult

Una vez que Invoke-GradioSessionApi es la ejecutada al fin de cuentas, todas las reglas de ellas se aplican.
Voce puede ser Get-GradioSessionApiProxyFunction para obtener una lista de lo que fue craido y Remove-GradioSessionApiProxyFunction para remover una o más funciones creadas.  
Las funciones son creadas con un modulo dinamico.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSessionApiProxyFunction [[-ApiName] <Object>] [[-Prefix] <Object>] [[-Session] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Crear solamente para este endpoint en específico

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -Prefix
Prefijo de las funciones creadas

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Invoke-GradioApi
Accept pipeline input: false
Accept wildcard characters: false
```

### -Session
Sesión

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Force
Fuerza la creación de la función, ¡incluso si ya existe una con el mismo nombre!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
