---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiMessage

## SYNOPSIS <!--!= @#Synop !-->
Convierte una matriz de cadenas y objetos a un formato de mensaje estándar de OpenAI!

## DESCRIPTION <!--!= @#Desc !-->
Puedes pasar una matriz mixta donde cada elemento puede ser una cadena o un objeto.
Si es una cadena, puede comenzar con el prefijo s, u o a, que significa, respectivamente, system, user o assistant.
Si es un objeto, se agrega directamente a la matriz resultante.

Ver: https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiMessage [[-prompt] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
ConvertTo-OpenaiMessage "Este es un texto",@{role:"assistant";content="Respuesta del asistente"}, "s:Mensaje del sistema"
```


## PARAMETERS <!--!= @#Params !-->

### -prompt

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


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
