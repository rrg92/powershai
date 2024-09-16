---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultModel

## SYNOPSIS <!--!= @#Synop !-->
Configurar el LLM predeterminado del proveedor actual

## DESCRIPTION <!--!= @#Desc !-->
Los usuarios pueden configurar el LLM predeterminado, que se usará cuando se necesite un LLM.  
Los comandos como Send-PowershaAIChat, Get-AiChat, esperan un modelo, y si no se proporciona, usarán el que se definió con este comando.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultModel [[-model] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model
Id del modelo, tal como lo devuelve Get-AiModels
Puede usar la tecla Tab para completar la línea de comandos.

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
Fuerza la definición del modelo, incluso si no se devuelve por Get-AiModels

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
