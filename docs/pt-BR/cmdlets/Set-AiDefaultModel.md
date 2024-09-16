---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultModel

## SYNOPSIS <!--!= @#Synop !-->
Configurar o LLM default do provider atual

## DESCRIPTION <!--!= @#Desc !-->
Usuários podem configurar o LLM default, que será usado quando um LLM for necessário.  
Comandos como Send-PowershaAIChat, Get-AiChat, esperam um modelo, e se não for informado, ele usa o que foi definido com esse comando.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultModel [[-model] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model
Id do modelo, conforme retornado por Get-AiModels
Você pode usar tab para completar a linha de comando.

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
Força definir o modelo, mesmo que não seja retornaod por Get-AiModels

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