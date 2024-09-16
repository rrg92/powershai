---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Gets all created sessions, or one with a specific name.

## SYNTAX <!--!= @#Syntax !-->

```
Get-GradioSession [[-Session] <Object>] [-Like] [-ById] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Session
Specify the session name.
* gets all 
. gets the default

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
If -name is a string, performs a search using -like operator

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
Get by id (Session must by a id)

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
