---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiError

## SYNOPSIS <!--!= @#Synop !-->
Erstellt eine neue benutzerdefinierte Exception für PowershaAI

## DESCRIPTION <!--!= @#Desc !-->
Erleichtert die Erstellung von benutzerdefinierten Ausnahmen!
Wird intern von Anbietern verwendet, um Ausnahmen mit Eigenschaften und Typen zu erstellen, die später wiederhergestellt werden können.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiError [[-Message] <Object>] [[-Props] <Object>] [[-Type] <Object>] [[-Parent] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Message
Die Meldung der Ausnahme!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Props
Benutzerdefinierte Eigenschaften

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Type
Zusätzlicher Typ!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Parent
Übergeordnete Ausnahme!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```



<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
