---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
Erstellt einen virtuellen Textrahmen und schreibt Zeichen innerhalb der Grenzen dieses Rahmens

## DESCRIPTION <!--!= @#Desc !-->
Erstellt einen Zeichenrahmen in der Konsole, der nur in einem bestimmten Bereich aktualisiert wird!
Sie können mehrere Textzeilen senden und die Funktion kümmert sich darum, die Zeichnung im selben Rahmen zu halten, was den Eindruck erweckt, dass nur ein Bereich aktualisiert wird.
Für den gewünschten Effekt muss diese Funktion wiederholt aufgerufen werden, ohne weitere Schreibvorgänge zwischen den Aufrufen!

Diese Funktion sollte nur im interaktiven Modus von Powershell verwendet werden, der in einem Konsolenfenster ausgeführt wird.
Sie ist nützlich, wenn Sie den Fortschritt eines Streingergebnisses genau im selben Bereich sehen möchten, um Variationen besser vergleichen zu können.
Es ist nur eine Hilfsfunktion.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] [-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
Das folgende Beispiel schreibt alle 2 Sekunden 3 Textstrings.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
Text, der geschrieben werden soll. Kann ein Array sein. Wenn er die Grenzen von W und H überschreitet, wird er abgeschnitten.
Wenn es sich um einen Scriptblock handelt, ruft den Code auf und übergibt das Objekt aus der Pipeline!

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

### -w
Max. Zeichen pro Zeile

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -h
Max. Zeilen

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -BlankChar
Zeichen, das als leerer Raum verwendet wird

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

### -PipeObj
Objekt aus der Pipeline

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -PassThru
Gibt das Objekt weiter

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
