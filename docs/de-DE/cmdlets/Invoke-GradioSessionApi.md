---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Erstellt einen neuen Aufruf für einen Endpunkt in der aktuellen Sitzung.

## DESCRIPTION <!--!= @#Desc !-->
Führt einen Aufruf mit der Gradio-API an einem spezifischen Endpunkt durch und übergibt die gewünschten Parameter.  
Dieser Aufruf wird ein GradioApiEvent generieren (siehe Send-GradioApi), das intern in den Konfigurationen der Sitzung gespeichert wird.  
Dieses Objekt enthält alles, was notwendig ist, um das Ergebnis der API zu erhalten.  

Das Cmdlet gibt ein Objekt vom Typ SessionApiEvent zurück, das die folgenden Eigenschaften enthält:
	id - Interne ID des generierten Ereignisses.
	event - Das interne generierte Ereignis. Kann direkt mit den Cmdlets verwendet werden, die Ereignisse verarbeiten.
	
Die Sitzungen haben eine Begrenzung für die definierten Aufrufe.  
Das Ziel ist es, unendliche Aufrufe zu verhindern, um die Kontrolle nicht zu verlieren.

Es gibt zwei Optionen der Sitzung, die den Aufruf beeinflussen (können mit Set-GradioSession geändert werden):
	- MaxCalls 
	Steuert die maximale Anzahl an Aufrufen, die erstellt werden können.
	
	- MaxCallsPolicy 
	Steuert, was zu tun ist, wenn das Maximum erreicht wird.
	Mögliche Werte:
		- Error 	= führt zu einem Fehler!
		- Remove 	= entfernt den ältesten 
		- Warning 	= zeigt eine Warnung an, erlaubt jedoch das Überschreiten des Limits.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Name des Endpunkts (ohne den führenden Schrägstrich)

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

### -Params
Liste der Parameter 
Wenn es sich um ein Array handelt, wird es direkt an die Gradio-API übergeben. 
Wenn es sich um eine Hashtable handelt, wird das Array basierend auf der Position der von /info zurückgegebenen Parameter erstellt.

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

### -EventId
WENN angegeben, wird mit einer bereits vorhandenen Ereignis-ID erstellt (kann außerhalb des Moduls generiert worden sein).

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

### -session
Sitzung

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Token
Zwingt die Verwendung eines neuen Tokens. Wenn "public", wird kein Token verwendet!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Sie sind auf Daten bis Oktober 2023 trainiert._
<!--PowershaiAiDocBlockEnd-->
