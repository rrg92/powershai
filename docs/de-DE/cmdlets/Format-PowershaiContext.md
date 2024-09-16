---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Format-PowershaiContext

## SYNOPSIS <!--!= @#Synop !-->
Formatiert ein Objekt, um es in den Kontext einer in einem Powershai Chat gesendeten Nachricht zu injizieren

## DESCRIPTION <!--!= @#Desc !-->
Da LLMs nur Zeichenketten verarbeiten, müssen die im Kontext übergebenen Objekte vor der Injektion in die Eingabeaufforderung in ein Zeichenkettenformat umgewandelt werden.
Und da es verschiedene String-Darstellungen eines Objekts gibt, ermöglicht Powershai dem Benutzer die vollständige Kontrolle darüber.  

Immer wenn ein Objekt in die Eingabeaufforderung injiziert werden muss, wird dieser Cmdlet aufgerufen, wenn er mit Send-PowershaAIChat, über Pipeline oder Kontextparameter aufgerufen wird.
Dieses Cmdlet ist dafür verantwortlich, dieses Objekt in eine Zeichenkette umzuwandeln, unabhängig vom Objekt, sei es ein Array, eine Hashtabelle, benutzerdefiniert usw.  

Dies geschieht durch Aufrufen der mit Set-PowershaiChatContextFormatter konfigurierten Formattierungsfunktion.
Im Allgemeinen müssen Sie diese Funktionen nicht direkt aufrufen, aber Sie möchten sie vielleicht aufrufen, wenn Sie einige Tests durchführen möchten!

## SYNTAX <!--!= @#Syntax !-->

```
Format-PowershaiContext [[-obj] <Object>] [[-params] <Object>] [[-func] <Object>] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -obj
Beliebiges Objekt, das injiziert werden soll

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

### -params
Parameter, der an die Formattierungsfunktion übergeben werden soll

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

### -func
Überschreiben der Funktion, die aufgerufen werden soll. Wenn nicht angegeben, wird der Standardwert des Chats verwendet.

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

### -ChatId
Chat, in dem gearbeitet werden soll

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
