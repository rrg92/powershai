---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
Erstellt einen virtuellen Textrahmen und schreibt Zeichen innerhalb der Grenzen dieses Rahmens

## DESCRIPTION <!--!= @#Desc !-->
Erstellt einen Zeichnungsrahmen in der Konsole, der nur in einem bestimmten Bereich aktualisiert wird!
Sie können mehrere Zeilen Text senden und die Funktion wird dafür sorgen, dass die Zeichnung im selben Rahmen bleibt, was den Eindruck erweckt, dass nur ein Bereich aktualisiert wird.
Für den gewünschten Effekt sollte diese Funktion wiederholt aufgerufen werden, ohne andere Writes zwischen den Aufrufen!

Diese Funktion sollte nur im interaktiven Modus von PowerShell verwendet werden, der in einem Konsolenfenster ausgeführt wird.
Sie ist nützlich in Situationen, in denen Sie den Fortschritt eines Ergebnisses in einer Zeichenfolge genau im selben Bereich sehen möchten, um Variationen besser vergleichen zu können.
Es ist nur eine Hilfsfunktion.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] 
[-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
Das folgende Beispiel schreibt alle 2 Sekunden 3 Textzeichenfolgen.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
Zu schreibender Text. Kann ein Array sein. Wenn die Grenzen von W und H überschritten werden, wird er abgeschnitten. 
Wenn es sich um einen Skriptblock handelt, wird der Code aufgerufen und das Pipeline-Objekt übergeben!

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
Maximale Anzahl von Zeichen pro Zeile

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
Maximale Anzahl von Zeilen

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
Zeichen, das als Leerraum verwendet wird

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
Pipeline-Objekt

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
Gibt das Objekt zurück

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
