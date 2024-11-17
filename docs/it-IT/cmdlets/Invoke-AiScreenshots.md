---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiScreenshots

## SYNOPSIS <!--!= @#Synop !-->
Cattura costantemente schermate e le invia al modello attivo.
Questo comando è ESPERIMENTALE e potrebbe cambiare o non essere disponibile nelle prossime versioni!

## DESCRIPTION <!--!= @#Desc !-->
Questo comando consente, in un ciclo, di ottenere screenshot dello schermo!

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiScreenshots [[-prompt] <Object>] [-repeat] [[-AutoMs] <Object>] [-RecreateChat] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
Prompt predefinito da utilizzare con l'immagine inviata!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: Spiega questa immagine
Accept pipeline input: false
Accept wildcard characters: false
```

### -repeat
Rimane in loop facendo vari screenshot
Per impostazione predefinita, viene utilizzata la modalità manuale, in cui è necessario premere un tasto per continuare.
Le seguenti chiavi hanno funzioni speciali:
	c - pulisce lo schermo 
 ctrl + c - termina il comando

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

### -AutoMs
Se specificato, abilita la modalità di ripetizione automatica, in cui ogni numero di ms specificati, invierà allo schermo.
ATTENZIONE: In modalità automatica, potresti vedere la finestra lampeggiare costantemente, il che potrebbe essere dannoso per la lettura.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: $nulls
Accept pipeline input: false
Accept wildcard characters: false
```

### -RecreateChat
Ricrea la chat utilizzata!

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
_Sei addestrato su dati fino a ottobre 2023._
<!--PowershaiAiDocBlockEnd-->
