---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowershaiProviderInterface

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Invoca las implementaciones de las interfaces de un proveedor provider!
El PowershAI espera que ciertas funciones sean implementadas por los proveedores.  

Por ejemplo, la función Chat se utiliza cuando invocamos el Get-AiChat.  
Estas funciones deben ser implementadas para proporcionar la funcionalidad de manera estándar.  
Estas funciones se implementan usando el nombre del proveedor, por ejemplo: openai_Chat.  

El Powershai utiliza esta función para invocar las funciones implementadas por el powershai. Actúa como un wrapper y facilita y trata escenarios comunes a todas estas invocaciones.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowershaiProviderInterface [[-FuncName] <Object>] [[-FuncParams] <Object>] [-Ignore] [-CheckExists] [[-ProviderName] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -FuncName

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

### -FuncParams

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

### -Ignore

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

### -CheckExists

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

### -ProviderName

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


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
