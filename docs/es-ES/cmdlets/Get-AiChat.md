---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
Envía mensajes a un LLM y retorna la respuesta

## DESCRIPTION <!--!= @#Desc !-->
Esta es la forma más básica de Chat promovida por PowershAI.  
Con esta función, puede enviar un mensaje a un LLM del proveedor actual.  

Esta función es más bajo nivel, de manera estandarizada, de acceso a un LLM que el powershai disponibiliza.  
No gestiona historial ni contexto. Es útil para invocar prompts simples, que no requieren varias interacciones como en un Chat. 
A pesar de soportar el Functon Calling, no ejecuta ningún código, y solo devuelve la respuesta del modelo.



** INFORMACION PARA PROVIDERS
	El proveedor debe implementar la función Chat para que esta funcionalidad esté disponible. 
	La función chat debe retornar un objeto con la respuesta con la misma especificación de la OpenAI, función Chat Completion.
	Los links a continuación sirven de base:
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (retorno sin streaming)
	El proveedor debe implementar los parámetros de esta función. 
	Vea la documentación de cada parámetro para detalles y como mapear para un proveedor;
	
	Cuando el modelo no soporte uno de los parámetros informados (esto es, no hubiera funcionalidad equivalente, o que pueda ser implementada de manera equivalente) un error deberá ser retornado.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] [[-Functions] <Object>] [[-RawParams] 
<Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
El prompt a ser enviado. Debe ser en el formato descrito por la función ConvertTo-OpenaiMessage

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

### -temperature
Temperatura del modelo

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 0.6
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
Nombre del modelo. Si no se especifica, usa el default del proveedor.

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

### -MaxTokens
Máximo de tokens a ser retornado

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 1024
Accept pipeline input: false
Accept wildcard characters: false
```

### -ResponseFormat
Formato de la respuesta 
Los formatos aceptables, y comportamiento, deben seguir el mismo de la OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
Atalhos:
	"json", equivale a {"type": "json_object"}

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

### -Functions
Lista de tools que deben ser invocadas!
Puede usar el comandos como Get-OpenaiTool*, para transformar funciones powershell fácilmente en el formato esperado!
Si el modelo invoca la función, la respuesta, tanto en stream, cuanto normal, debe también seguir el modelo de tool caling de la OpenAI.
Este parámetro debe seguir el mismo esquema del Function Calling de la OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Especifique parámetros directos de la API del proveedor.
Esto irá a sobrescribir los valores que fueron calculados y gerados con base en los otros parámetros.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 7
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -StreamCallback
Habilita el modelo Stream 
Debe especificar un ScriptBlock que será invocado para cada texto generado por el LLM.
El script debe recibir un parámetro que representa cada trecho, en el mismo formato de streaming retornado
	Este parámetro es un objeto que contendrá la propiedad choices, que es en el mismo esquema retornado por el streaming de la OpenAI:
		https://platform.openai.com/docs/api-reference/chat/streaming

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 8
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -IncludeRawResp
Incluir la respuesta de la API en un campo llamado IncludeRawResp

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
