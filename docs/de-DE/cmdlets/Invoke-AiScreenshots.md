---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AiScreenshots

## SYNOPSIS <!--!= @#Synop !-->
Macht konstante Screenshots des Bildschirms und sendet sie an das aktive Modell.
Dieser Befehl ist EXPERIMENTELL und kann sich ändern oder in zukünftigen Versionen möglicherweise nicht verfügbar sein!

## DESCRIPTION <!--!= @#Desc !-->
Dieser Befehl ermöglicht es, in einer Schleife Screenshots des Bildschirms zu erhalten!

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-AiScreenshots [[-prompt] <Object>] [-repeat] [[-AutoMs] <Object>] [-RecreateChat] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
Standardaufforderung, die mit dem gesendeten Bild verwendet werden soll!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: Erkläre dieses Bild
Accept pipeline input: false
Accept wildcard characters: false
```

### -repeat
Bleibt in einer Schleife und macht mehrere Screenshots.
Standardmäßig wird der manuelle Modus verwendet, in dem Sie eine Taste drücken müssen, um fortzufahren.
Die folgenden Tasten haben spezielle Funktionen:
	c - löscht den Bildschirm 
 ctrl + c - beendet den Befehl

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
Wenn angegeben, aktiviert es den automatischen Wiederholungsmodus, in dem es alle angegebenen ms den Bildschirm sendet.
ACHTUNG: Im automatischen Modus können Sie sehen, dass das Fenster ständig blinkt, was das Lesen erschweren kann.

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
Erstellt den verwendeten Chat neu!

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
_Sie sind auf Daten bis Oktober 2023 trainiert._
<!--PowershaiAiDocBlockEnd-->
