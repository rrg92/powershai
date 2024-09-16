---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Ottiene tutte le sessioni create, o una con un nome specifico.

## SYNTAX <!--!= @#Syntax !-->

```
Get-GradioSession [[-Session] <Object>] [-Like] [-ById] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Session
Specifica il nome della sessione.
* ottenere tutte 
. ottenere la default

```yml
Parameter Set: (All)
Type: Object
Aliases: Name
Accepted Values: 
Required: false
Position: 1
Default Value: *
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Like
Se -name è una stringa, esegue una ricerca usando l'operatore -like

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

### -ById
Ottieni per id (la sessione deve essere un id)

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
