---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
Restituisce l'elenco di parametri disponibili in una chat

## DESCRIPTION <!--!= @#Desc !-->
Questo comando restituisce un oggetto contenente l'elenco delle proprietà.  
L'oggetto è in realtà un array, in cui ogni elemento rappresenta una proprietà.  

Questo array restituito ha alcune modifiche per facilitare l'accesso ai parametri. 
È possibile accedere ai parametri utilizzando direttamente l'oggetto restituito, senza la necessità di filtrare sull'elenco di parametri.
Questo è utile quando si desidera accedere a un parametro specifico dell'elenco.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatParameter [[-ChatId] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
$MyParams = Get-PowershaiChatParameter
```


## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
