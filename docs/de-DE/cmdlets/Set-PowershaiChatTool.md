---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Deaktiviert ein Tool (aber nicht entfernen). Deaktivierte Tools werden nicht an den LLM gesendet.

## SYNTAX <!--!= @#Syntax !-->

### Enable
```
Set-PowershaiChatTool [-tool <Object>] [-Enable] [-ForceCommand] [-ChatId <Object>] [-Global] [<CommonParameters>]
```

### Disable
```
Set-PowershaiChatTool [-tool <Object>] [-Disable] [-ForceCommand] [-ChatId <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
Name des Tools (gleiche wie bei Add-PowershaiChatTool) oder als Pipe-Eingabe das Ergebnis von Get-PowershaiChatTool.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Enable
Aktiviert das Tool.

```yml
Parameter Set: Enable
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -Disable
Deaktiviert das Tool.

```yml
Parameter Set: Disable
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ForceCommand
Wenn angegeben und das Tool ein Name ist, erzwingt dies, dass es als Skript behandelt wird!

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
Chat, in dem sich das Tool befindet.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Global
Sucht das Tool in der globalen Liste der Tools.

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
