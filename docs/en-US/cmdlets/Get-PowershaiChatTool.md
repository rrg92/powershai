---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Get the list of current tools.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatTool [[-tool] <Object>] [-Enabled] [[-ChatId] <Object>] [-global] [-ForceCommand] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
get specific by name or the object itself!
If ending in a .ps1, treats as script, unless ForceCommand is used!

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
list only the enabled tools

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
Chat of origin

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
When getting a specific tool, look in the global tools list.

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
Treat tool as a command!

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
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
