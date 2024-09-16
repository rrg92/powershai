---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
Cambia il provider corrente

## DESCRIPTION <!--!= @#Desc !-->
I provider sono script che implementano l'accesso alle loro rispettive API.  
Ogni provider ha il suo modo di invocare le API, il formato dei dati, lo schema della risposta, ecc.  

Cambiando il provider, si influenzano alcuni comandi che operano sul provider corrente, come `Get-AiChat`, `Get-AiModels`, o le Chat, come Send-PowershaAIChat.
Per maggiori dettagli sui provider consultare il topic about_Powershai_Providers

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -provider
nome del provider

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
