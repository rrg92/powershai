---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Devuelve uno o más Chats creados con New-PowershaAIChat

## DESCRIPTION <!--!= @#Desc !-->
Este comando permite devolver el objeto que representa un Powershai Chat.  
Este objeto es el objeto referenciado internamente por los comandos que operan en el Powershai Chat.  
Aunque ciertos parámetros se pueden modificar directamente, no se recomienda realizar esta acción.  
Siempre prefiera utilizar la salida de este comando como entrada para los demás comandos PowershaiChat.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChat [[-ChatId] <Object>] [-SetActive] [-NoError] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Id del chat
Nombres especiales:
	. - Indica el propio chat 
 	* - Indica todos los chats

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

### -SetActive
Define el chat como activo, cuando el id especifciado no es un nombre especial.

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

### -NoError
Ignora errores de validación

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
