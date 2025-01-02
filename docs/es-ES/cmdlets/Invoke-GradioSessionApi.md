---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Crea una nueva llamada a un endpoint en la sesión actual.

## DESCRIPTION <!--!= @#Desc !-->
Realiza una llamada utilizando la API de Gradio, en un endpoint específico y pasando los parámetros deseados.  
Esta llamada generará un GradioApiEvent (ver Send-GradioApi), que se guardará internamente en las configuraciones de la sesión.  
Este objeto contiene todo lo necesario para obtener el resultado de la API.  

El cmdlet devolverá un objeto del tipo SessionApiEvent que contiene las siguientes propiedades:
	id - Id interno del evento generado.
	event - El evento interno generado. Puede ser utilizado directamente con los cmdlets que manipulan eventos.
	
Las sesiones tienen un límite de llamadas definidas.
El objetivo es evitar crear llamadas indefinidas de manera que se pierda el control.

Existen dos opciones de la sesión que afectan la llamada (pueden ser alteradas con Set-GradioSession):
	- MaxCalls 
	Controla el máximo de llamadas que pueden ser creadas
	
	- MaxCallsPolicy 
	Controla qué hacer cuando se alcanza el máximo.
	Valores posibles:
		- Error 	= resulta en error!
		- Remove 	= elimina la más antigua 
		- Warning 	= Muestra una advertencia, pero permite superar el límite.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Nombre del endpoint (sin la barra inicial)

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

### -Params
Lista de parámetros 
Si es un array, se pasa directamente a la API de Gradio 
Si es una hashtable, se monta el array con base en la posición de los parámetros devueltos por /info

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

### -EventId
SI se especifica, crea con un evento id ya existente (puede haber sido generado fuera del módulo).

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

### -session
Sesión

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Token
Forzar el uso de un nuevo token. Si "public", entonces no usa ningún token!

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


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
