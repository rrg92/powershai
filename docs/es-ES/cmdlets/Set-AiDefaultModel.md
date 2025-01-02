---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultModel

## SYNOPSIS <!--!= @#Synop !-->
Configurar el LLM predeterminado del proveedor actual

## DESCRIPTION <!--!= @#Desc !-->
Los usuarios pueden configurar el LLM predeterminado, que se utilizará cuando se necesite un LLM.  
Comandos como Send-PowershaAIChat, Get-AiChat, esperan un modelo, y si no se especifica, utiliza el que se ha definido con este comando.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultModel [[-model] <Object>] [-Force] [-Embeddings] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model
Id del modelo, según lo devuelto por Get-AiModels
Puedes usar tab para completar la línea de comando.

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

### -Force
Forza establecer el modelo, incluso si no es devuelto por Get-AiModels

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

### -Embeddings
¡Define el modelo de embedding!

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
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
