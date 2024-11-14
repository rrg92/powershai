---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
Aggiorna il ritorno di una chiamata generata come Invoke-GradioSessionApi

## DESCRIPTION <!--!= @#Desc !-->
Questo cmdlet segue lo stesso principio dei suoi equivalenti in Send-GradioApi e Update-GradioApiResult.
Tuttavia, funziona solo per gli eventi generati in una sessione specifica.
Restituisce l'evento stesso in modo che possa essere utilizzato con altri cmdlet che dipendono dall'evento aggiornato!

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Id
Id dell'evento, restituito da Invoke-GradioSessionApi o l'oggetto stesso restituito.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -NoOutput
Non restituire il risultato all'output!

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

### -MaxHeartBeats
Max heartbeat consecutivi.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -session
Id della sessione

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -History
Aggiunge gli eventi nella cronologia degli eventi dell'oggetto GradioApiEvent specificato in -Id

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
_Sei stato addestrato su dati fino a ottobre 2023._
<!--PowershaiAiDocBlockEnd-->
