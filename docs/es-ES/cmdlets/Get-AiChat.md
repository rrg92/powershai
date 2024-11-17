---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiChat

## SYNOPSIS <!--!= @#Synop !-->
Envía mensajes a un LLM y devuelve la respuesta

## DESCRIPTION <!--!= @#Desc !-->
Esta es la forma más básica de Chat promovida por PowershAI.  
Con esta función, puedes enviar un mensaje a un LLM del proveedor actual.  

Esta función es de bajo nivel, de manera estandarizada, para acceder a un LLM que PowershAI proporciona.  
No gestiona historial ni contexto. Es útil para invocar prompts simples, que no requieren múltiples interacciones como en un Chat. 
A pesar de soportar el Function Calling, no ejecuta ningún código, y solo devuelve la respuesta del modelo.



** INFORMACIONES PARA PROVEEDORES
	El proveedor debe implementar la función Chat para que esta funcionalidad esté disponible. 
	La función chat debe devolver un objeto con la respuesta con la misma especificación de OpenAI, función Chat Completion.
	Los siguientes enlaces sirven de base:
		https://platform.openai.com/docs/guides/chat-completions
		https://platform.openai.com/docs/api-reference/chat/object (retorno sin streaming)
	El proveedor debe implementar los parámetros de esta función. 
	Consulta la documentación de cada parámetro para detalles y cómo mapear a un proveedor;
	
	Cuando el modelo no soporte uno de los parámetros informados (es decir, no haya funcionalidad equivalente, o que pueda ser implementada de manera equivalente) se debe devolver un error.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiChat [[-prompt] <Object>] [[-temperature] <Object>] [[-model] <Object>] [[-MaxTokens] <Object>] [[-ResponseFormat] <Object>] 
[[-Functions] <Object>] [[-RawParams] <Object>] [[-StreamCallback] <Object>] [-IncludeRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
El prompt a ser enviado. Debe estar en el formato descrito por la función ConvertTo-OpenaiMessage

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
Nombre del modelo. Si no se especifica, usa el predeterminado del proveedor.

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
Máximo de tokens a ser devueltos

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
Los formatos aceptables, y comportamiento, deben seguir el mismo de OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-response_format
Atajos:
	"json"|"json_object", equivale a {"type": "json_object"}
	el objeto debe especificar un esquema como si fuera pasado directamente a la API de OpenAI, en el campo response_format.json_schema

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
Lista de herramientas que deben ser invocadas!
Puedes usar los comandos como Get-OpenaiTool*, para transformar funciones de PowerShell fácilmente en el formato esperado!
Si el modelo invoca la función, la respuesta, tanto en streaming, como normal, también debe seguir el modelo de tool calling de OpenAI.
Este parámetro debe seguir el mismo esquema del Function Calling de OpenAI: https://platform.openai.com/docs/api-reference/chat/create#chat-create-tools

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
Especifica parámetros directos de la API del proveedor.
Esto sobrescribirá los valores que fueron calculados y generados con base en los otros parámetros.

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
Debes especificar un ScriptBlock que será invocado para cada texto generado por el LLM.
El script debe recibir un parámetro que representa cada fragmento, en el mismo formato de streaming devuelto
	Este parámetro es un objeto que contendrá la propiedad choices, que es el mismo esquema devuelto por el streaming de OpenAI:
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
_Estás entrenado en datos hasta octubre de 2023._
<!--PowershaiAiDocBlockEnd-->
