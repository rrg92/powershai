---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Erstellt einen neuen Aufruf für einen Endpunkt in der aktuellen Sitzung.

## DESCRIPTION <!--!= @#Desc !-->
Führt einen Aufruf über die Gradio-API aus, auf einen bestimmten Endpunkt und mit den gewünschten Parametern.  
Dieser Aufruf generiert ein GradioApiEvent (siehe Send-GradioApi), das intern in den Sitzungseinstellungen gespeichert wird.  
Dieses Objekt enthält alles, was zum Abrufen des API-Ergebnisses erforderlich ist.  

Das Cmdlet gibt ein Objekt vom Typ SessionApiEvent zurück, das die folgenden Eigenschaften enthält:
	id - Interne ID des generierten Ereignisses.
	event - Das intern generierte Ereignis. Kann direkt mit den Cmdlets verwendet werden, die Ereignisse verarbeiten.
	
Sitzungen haben ein Limit für definierte Aufrufe.
Der Zweck ist, die unbegrenzte Erstellung von Aufrufen zu verhindern, die den Kontrollverlust verursachen können.

Es gibt zwei Sitzungsoptionen, die den Aufruf beeinflussen (diese können mit Set-GradioSession geändert werden):
	- MaxCalls 
	Steuert die maximale Anzahl von Aufrufen, die erstellt werden können.
	
	- MaxCallsPolicy 
	Steuert, was zu tun ist, wenn der Max-Wert erreicht wird.
	Mögliche Werte:
		- Error 	= führt zu einem Fehler!
		- Remove 	= entfernt die älteste
		- Warning 	= Zeigt eine Warnung an, ermöglicht aber das Überschreiten des Limits.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Name des Endpunkts (ohne anfänglichen Schrägstrich)

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
Wenn es sich um eine Hashtabelle handelt, wird das Array basierend auf der Position der Parameter erstellt, die von /info zurückgegeben werden.

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
Wenn angegeben, wird mit einer bereits vorhandenen Event-ID erstellt (diese kann außerhalb des Moduls generiert worden sein).

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
Erzwingt die Verwendung eines neuen Tokens. Wenn "public", wird kein Token verwendet!

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
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
