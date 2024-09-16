---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
Aktualisiert die Rückgabe einer Call, die als Invoke-GradioSessionApi generiert wurde

## DESCRIPTION <!--!= @#Desc !-->
Dieses Cmdlet folgt dem gleichen Prinzip wie seine Gegenstücke in Send-GradioApi und Update-GradioApiResult.
Es funktioniert jedoch nur für die Ereignisse, die in einer bestimmten Sitzung generiert wurden.
Gibt das Ereignis selbst zurück, damit es mit anderen Cmdlets verwendet werden kann, die das aktualisierte Ereignis benötigen!

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] [<CommonParameters>]
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
Das Ergebnis nicht an die Ausgabe zurückgeben!

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
Maximal zulässige aufeinanderfolgende Heartbeats.

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
Fügt das Ereignis zum Ereignisverlauf des in -Id angegebenen GradioApiEvent-Objekts hinzu.

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
