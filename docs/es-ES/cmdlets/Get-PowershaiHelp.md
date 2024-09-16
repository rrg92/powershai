---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiHelp

## SYNOPSIS <!--!= @#Synop !-->
Usa el proveedor actual para ayudar a obtener ayuda sobre powershai!

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet utiliza los propios comandos del PowershAI para ayudar al usuario a obtener ayuda sobre sí mismo.  
Básicamente, a partir de la pregunta del usuario, monta un prompt con algunas informaciones comunes y helps básicos.  
Entonces, esto es enviado al LLM en un chat.

Debido al gran volumen de datos enviados, es recomendable usar este comando solamente con providers y modeos que acepten más de 128k y que sean baratos.  
Por ahora, este comando es experimental y funciona penas con estos modelos:
	- Openai gpt-4*
	
Internamente, irá crear un Powershai Chat llamado "_pwshai_help", donde mantendrá todo el histórico!

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -helptext
Describe el texto de ayuda!

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

### -command
Si quieres help de un comando específico, informa el comando aquí 
No necesita ser solamente un comando del PowershaiChat.

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

### -Recreate
Recrea el chat!

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
