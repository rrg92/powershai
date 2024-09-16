---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Funzione di supporto per convertire uno script .ps1 in un formato di schema previsto da OpenAI.
Fondamentalmente, ciò che fa questa funzione è leggere un file .ps1 (o stringa) insieme alla sua documentazione di help.  
Quindi, restituisce un oggetto nel formato specificato da OpenAI in modo che il modello possa essere invocato!

Restituisce un hashtable contenente le seguenti chiavi:
	functions - L'elenco delle funzioni, con il codice letto dal file.  
				Quando il modello viene invocato, puoi eseguire direttamente da qui.
				
	tools - Elenco degli strumenti, da inviare nella chiamata a OpenAI.
	
È possibile documentare le funzioni e i parametri seguendo la guida basata sui commenti di PowerShell:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-ScriptPath] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ScriptPath

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
