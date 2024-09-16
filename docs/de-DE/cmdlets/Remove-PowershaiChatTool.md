---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Entfernt ein Tool endgültig!

## SYNTAX <!--!= @#Syntax !-->

```
Remove-PowershaiChatTool [[-tool] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
Name des Befehls, Skripts, Funktionen, das zuvor als Tool hinzugefügt wurde.
Wenn es sich um eine .ps1-Datei handelt, wird sie als Skript behandelt, es sei denn, -Force command wird verwendet.
Sie können das Ergebnis von Get-PowershaiChatTool über Pipe an diesen Befehl senden, den er dann erkennen wird.
Beim Senden des zurückgegebenen Objekts werden alle anderen Parameter ignoriert.

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

### -ForceCommand
Erzwingt die Behandlung des Tools als Befehl, wenn es eine Zeichenkette ist

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

### -ChatId
Chat, aus dem entfernt werden soll

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -global
Aus der globalen Liste entfernen, wenn das Tool zuvor als global hinzugefügt wurde

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
