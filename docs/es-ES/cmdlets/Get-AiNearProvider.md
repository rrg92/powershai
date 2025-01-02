---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiNearProvider

## SYNOPSIS <!--!= @#Synop !-->
Obtiene el provider más reciente del script actual

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet es comúnmente utilizado por los providers de forma indirecta a través de Get-AiCurrentProvider.  
Mira en la callstack de powershell e identifica si el caller (la función que ejecutó) forma parte de un script de un provider.  
Si es así, devuelve ese provider.

Si la llamada se hizo en múltiples providers, el más reciente es retornado. Por ejemplo, imagina este escenario:

	Usuario -> Get-aiChat -> ProviderX_Function -> ProviderY_Function -> Get-AiNearProvider
	
En este caso, nota que hay 2 llamadas de providers involucradas.  
En este caso, la función Get-AiNearProvider retornará el provider Y, ya que es el más reciente de la call stack.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiNearProvider [[-callstack] <Object>] [[-filter] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -callstack
Usar una call stack específica.
¡Este parámetro es útil cuando una función que invocó quiere que se considere mirar a partir de un punto específico!

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

### -filter
ScriptBlock con el filtro. $_ apunta al provider encontrado!

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


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
