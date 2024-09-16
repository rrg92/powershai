---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultModel

## SYNOPSIS <!--!= @#Synop !-->
Configura il modello LLM predefinito del provider corrente

## DESCRIPTION <!--!= @#Desc !-->
Gli utenti possono configurare il modello LLM predefinito, che verrà utilizzato quando è necessario un LLM.  
Comandi come Send-PowershaAIChat, Get-AiChat, si aspettano un modello, e se non è specificato, usa quello definito con questo comando.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultModel [[-model] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model
ID del modello, come restituito da Get-AiModels
Puoi usare la tab per completare la riga di comando.

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
Forza l'impostazione del modello, anche se non viene restituito da Get-AiModels

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
