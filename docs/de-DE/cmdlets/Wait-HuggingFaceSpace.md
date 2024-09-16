---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Wait-HuggingFaceSpace

## SYNOPSIS <!--!= @#Synop !-->
Warte, bis der Space gestartet ist. Gibt $true zurück, wenn der Start erfolgreich war, oder $false, wenn ein Timeout aufgetreten ist!

## SYNTAX <!--!= @#Syntax !-->

```
Wait-HuggingFaceSpace [[-Space] <Object>] [-timeout <Object>] [-SleepTime <Object>] [-NoStatus] [-NoStart] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Space
Filtert nach einem bestimmten Space

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

### -timeout
Maximale Anzahl von Sekunden zum Warten. Wenn null, dann wartet er unendlich lange!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -SleepTime
Wartezeit bis zum nächsten Check, in ms

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 5000
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoStatus
gibt keinen Fortschrittsstatus aus...

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

### -NoStart
Startet nicht, nur warten!

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
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
