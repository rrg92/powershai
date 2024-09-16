---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Ruft alle erstellten Sitzungen ab oder eine Sitzung mit einem bestimmten Namen.

## SYNTAX <!--!= @#Syntax !-->

```
Get-GradioSession [[-Session] <Object>] [-Like] [-ById] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Session
Gibt den Namen der Sitzung an.
* Alle abrufen
. Die Standardeinstellung abrufen

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
Wenn -name eine Zeichenkette ist, wird eine Suche mit dem -like-Operator durchgeführt.

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
Abrufen nach ID (Sitzung muss eine ID sein)

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
