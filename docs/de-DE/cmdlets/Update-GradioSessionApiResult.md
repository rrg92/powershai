---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
Aktualisiert das Ergebnis eines Aufrufs, der mit Invoke-GradioSessionApi erstellt wurde.

## DESCRIPTION <!--!= @#Desc !-->
Dieses Cmdlet folgt demselben Prinzip wie seine Äquivalente in Send-GradioApi und Update-GradioApiResult. 
Es funktioniert jedoch nur für die Ereignisse, die in einer bestimmten Sitzung generiert wurden. 
Es gibt das Ereignis selbst zurück, damit es mit anderen Cmdlets verwendet werden kann, die von dem aktualisierten Ereignis abhängen!

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Id
Id des Ereignisses, zurückgegeben von Invoke-GradioSessionApi oder das zurückgegebene Objekt selbst.

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

### -NoOutput
Gibt das Ergebnis nicht zurück!

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

### -MaxHeartBeats
Maximale aufeinanderfolgende Heartbeats.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -session
Id der Sitzung

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -History
Fügt die Ereignisse zum Ereignisverlauf des angegebenen GradioApiEvent-Objekts in -Id hinzu.

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
