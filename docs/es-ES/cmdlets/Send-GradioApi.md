---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Envía datos a un Gradio y retorna un objeto que representa el evento!
Pasa este objeto a los demás cmdlets para obtener los resultados.

FUNCIONAMIENTO DE LA API DE GRADIO 

	Basado en: https://www.gradio.app/guides/querying-gradio-apps-with-curl
	
	Para entender mejor como usar este cmdlet, es importante entender como la API de Gradio funciona.  
	Cuando invocamos algún endpoint de la API, él no retorna los datos inmediatamente.  
	Esto se debe al simple hecho del procesamiento ser extenso, debido a la naturaleza (IA y Machine Learning).  
	
	Entonces, al invés de retornar el resultado, o aguardar indefinidamente, el Gradio retorna un "Event Id".  
	Con este evento, conseguimos periodicamente obtener los resultaods generados.  
	El gradio va a generar mensajes de eventos con los datos que fueron generados. Necesitamos pasar el EventId generado para obtener los nuevos pedaços generados.
	Estos eventos son enviados vía Server Side Events (SSE), y pueden ser uno de estos:
		- hearbeat 
		A cada 15 segundos, el Gradio va a enviar este evento para mantener la conexión activa.  
		Por eso que, al usar el cmdlet Update-GradioApiResult, él puede demorar un poco para retornar.
		
		- complete 
		Es la última mensaje enviada por el Gradio cuando los datos fueron generados con éxito!
		
		- error 
		Enviado cuando hubo algún error en el procesamiento.  
		
		- generating
		Es generado cuando la API ya tiene datos disponibles, mas, aún puede venir más.
	
	Aquí en PowershAI, nosotros separamos esto también en 3 partes: 
		- Este cmdlet (Send-GradioApi) hace la requisición inicial para el Gradio y retorna un objeto que representa el evento (chamamods ele de un objeto GradioApiEvent)
		- Este objeto resultante, de tipo GradioApiEvent,  contiene todo lo que es necesario para consultar el evento y él también guarda los datos y errores obtenidos.
		- Por fim, tenemos el cmdlet Update-GradioApiResult, donde usted debe pasar el evento generado, y él irá consultar la API del gradio y obtener los nuevos datos.  
			Verifiaue el help deste cmdlet para más informaciones de como controlar este mecanismo de obtener los datos.
			
	
	Entonces, en un flixo normal, usted debe hacer lo siguiente: 
	
		#INvoque el endpoint del graido!
		$MeuEvento = SEnd-GradioApi ... 
	
		# Obtenha resultados hasta que tenha temrinado!
		# Verifique el help deste cmdlet para aprender más!
		$MeuEvento | Update-GradioApiResult
		
Objeto GradioApiEvent

	El objeto GradioApiEvent resultante deste cmdlet contiene todo lo que es necesario para que PowershAI controle el mecanismo y obtenga los datos.  
	Es importante que usted conozca su estructura para que sepa como colectar los datos generados por la API.
	Propiedades:
	
		- Status  
		Indica el status del evento. 
		Cuando este status for "complete", significa que la API ya terminó el procesamiento y todos los datos posibles ya fueron generados.  
		Mientras for diferente disso, usted debe invocar Update-GradioApiResult para que él chque el status y atualize as informacoes. 
		
		- QueryUrl  
		Valor interno que contiene el endpoint exato par a consulta dos resultados
		
		- data  
		Un array contendo todos os dados de resposta gerado. Cada vez que você invoca Update-GradioApiResult, se houver dados, ele irá adicionar a este array.  
		
		- events  
		Lista de eventos que fueron generados por el server. 
		
		- error  
		Se hubo errores en la respuesta, esse campio conterá algum objeto, string, etc., descrevendo mais detalles.
		
		- LastQueryStatus  
		Indica el status de la última consulta en la API.  
		Se "normal", indica que la API fue consultada y retornó hasta el fim normalmente.
		Se "HeartBeatExpired", indica que la consulta fue interrumpida debido al timeout de hearbeat configurado por el usuario en el cmdlet Update-GradioApiResult
		
		- req 
		Dados de la requisicao hecha!

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] [[-token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ApiName

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Params

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -SessionHash

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -EventId
Se informado, não chamada a API, mas cria o objeto e usa esse valor como se fosse o retorno

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -token

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
