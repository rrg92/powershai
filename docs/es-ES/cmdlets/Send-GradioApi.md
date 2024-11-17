---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioApi

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
¡Envía datos a un Gradio y devuelve un objeto que representa el evento!  
Pasa este objeto a los demás cmdlets para obtener los resultados.

FUNCIONAMIENTO DE LA API DE GRADIO 

    Basado en: https://www.gradio.app/guides/querying-gradio-apps-with-curl

    Para entender mejor cómo usar este cmdlet, es importante comprender cómo funciona la API de Gradio.  
    Cuando invocamos algún endpoint de la API, no devuelve los datos de inmediato.  
    Esto se debe al simple hecho de que el procesamiento es extenso, debido a la naturaleza (IA y Machine Learning).  
    
    Entonces, en lugar de devolver el resultado, o esperar indefinidamente, Gradio devuelve un "Event Id".  
    Con este evento, podemos obtener periódicamente los resultados generados.  
    Gradio generará mensajes de eventos con los datos que se han generado. Necesitamos pasar el EventId generado para obtener los nuevos fragmentos generados.  
    Estos eventos se envían a través de Server Side Events (SSE), y pueden ser uno de estos:  
        - heartbeat  
        Cada 15 segundos, Gradio enviará este evento para mantener la conexión activa.  
        Por eso, al usar el cmdlet Update-GradioApiResult, puede tardar un poco en devolver.  
        
        - complete  
        ¡Es el último mensaje enviado por Gradio cuando los datos se han generado con éxito!  
        
        - error  
        Enviado cuando hubo algún error en el procesamiento.  
        
        - generating  
        Se genera cuando la API ya tiene datos disponibles, pero aún puede venir más.  
    
    Aquí en PowershAI, también separamos esto en 3 partes:  
        - Este cmdlet (Send-GradioApi) realiza la solicitud inicial a Gradio y devuelve un objeto que representa el evento (lo llamamos un objeto GradioApiEvent).  
        - Este objeto resultante, de tipo GradioApiEvent, contiene todo lo necesario para consultar el evento y también almacena los datos y errores obtenidos.  
        - Por último, tenemos el cmdlet Update-GradioApiResult, donde debes pasar el evento generado, y consultará la API de Gradio y obtendrá los nuevos datos.  
            Consulta la ayuda de este cmdlet para más información sobre cómo controlar este mecanismo de obtención de datos.  
            
    Entonces, en un flujo normal, debes hacer lo siguiente:  
    
        # ¡Invoca el endpoint de Gradio!  
        $MiEvento = Send-GradioApi ...  
    
        # ¡Obtén resultados hasta que haya terminado!  
        # ¡Consulta la ayuda de este cmdlet para aprender más!  
        $MiEvento | Update-GradioApiResult  
        
Objeto GradioApiEvent

    El objeto GradioApiEvent resultante de este cmdlet contiene todo lo necesario para que PowershAI controle el mecanismo y obtenga los datos.  
    Es importante que conozcas su estructura para saber cómo recoger los datos generados por la API.  
    Propiedades:  
    
        - Status  
        Indica el estado del evento.  
        Cuando este estado sea "complete", significa que la API ya ha terminado el procesamiento y todos los datos posibles ya han sido generados.  
        Mientras sea diferente, debes invocar Update-GradioApiResult para que verifique el estado y actualice la información.  
        
        - QueryUrl  
        Valor interno que contiene el endpoint exacto para la consulta de resultados.  
        
        - data  
        Un array que contiene todos los datos de respuesta generados. Cada vez que invocas Update-GradioApiResult, si hay datos, los añadirá a este array.  
        
        - events  
        Lista de eventos que han sido generados por el servidor.  
        
        - error  
        Si hubo errores en la respuesta, este campo contendrá algún objeto, cadena, etc., describiendo más detalles.  
        
        - LastQueryStatus  
        Indica el estado de la última consulta a la API.  
        Si "normal", indica que la API fue consultada y devolvió hasta el final normalmente.  
        Si "HeartBeatExpired", indica que la consulta fue interrumpida debido al timeout de heartbeat configurado por el usuario en el cmdlet Update-GradioApiResult.  
        
        - req  
        ¡Datos de la solicitud realizada!  

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioApi [[-AppUrl] <Object>] [[-ApiName] <Object>] [[-Params] <Object>] [[-SessionHash] <Object>] [[-EventId] <Object>] 
[[-token] <Object>] [<CommonParameters>]
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
Si se proporciona, no llama a la API, sino que crea el objeto y usa este valor como si fuera la respuesta.

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
_Estás entrenado en datos hasta octubre de 2023._
<!--PowershaiAiDocBlockEnd-->
