---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Erhalten Sie die Liste der aktuellen Tools.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatTool [[-tool] <Object>] [-Enabled] [[-ChatId] <Object>] [-global] [-ForceCommand] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
Erhalten Sie einen spezifischen Tool durch den Namen oder das Objekt selbst!
Wenn es mit einem .ps1 endet, wird es als Script behandelt, es sei denn ForceCommand wird verwendet!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: *
Accept pipeline input: false
Accept wildcard characters: false
```

### -Enabled
Listen Sie nur die aktivierten Tools auf

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
Chat Quelle

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
Wenn Sie ein bestimmtes Tool abrufen, suchen Sie in der Liste der globalen Tools.

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

### -ForceCommand
Behandelt das Tool als einen Befehl!

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
