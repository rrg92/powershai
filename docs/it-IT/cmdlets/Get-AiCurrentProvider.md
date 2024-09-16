---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiCurrentProvider

## SYNOPSIS <!--!= @#Synop !-->
Ottiene il provider attivo

## DESCRIPTION <!--!= @#Desc !-->
Restituisce l'oggetto che rappresenta il provider attivo.  
I provider sono implementati come oggetti e sono memorizzati nella memoria della sessione, in una variabile globale.  
Questa funzione restituisce il provider attivo, che è stato definito con il comando Set-AiProvider.

L'oggetto restituito è una hashtable che contiene tutti i campi del provider.  
Questo comando è comunemente usato dai provider per ottenere il nome del provider attivo.  

Il parametro -ContextProvider restituisce il provider corrente in cui lo script sta eseguendo.  
Se sta eseguendo in uno script di un provider, restituirà quel provider, invece del provider definito con Set-AiProvider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
Se abilitato, usa il provider di contesto, ovvero se il codice sta eseguendo in un file nella directory di un provider, assume questo provider.
Altrimenti, ottiene il provider abilitato attualmente.

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
