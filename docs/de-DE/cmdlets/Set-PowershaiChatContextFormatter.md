---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS <!--!= @#Synop !-->
Definiert, welche Funktion zum Formatieren der an den Parameter Send-PowershaiChat -Context übergebenen Objekte verwendet wird.

## DESCRIPTION <!--!= @#Desc !-->
Wenn Send-PowershaiChat in einer Pipeline aufgerufen oder der Parameter -Context direkt übergeben wird, wird dieses Objekt in die Eingabeaufforderung des LLM eingefügt.  
Vor dem Einfügen muss dieses Objekt in eine Zeichenkette umgewandelt werden.  
Diese Umwandlung wird hier im Powershai als "Context Formatter" bezeichnet.  
Der Context Formatter ist eine Funktion, die jedes übergebene Objekt aufnimmt und in eine Zeichenkette umwandelt, die in die Eingabeaufforderung eingefügt werden soll.
Die verwendete Funktion muss das zu konvertierende Objekt als ersten Parameter empfangen.  

Die restlichen Parameter liegen im Ermessen. Ihre Werte können mithilfe des Parameters -Params dieser Funktion angegeben werden!

Powershai stellt native Context Formatter zur Verfügung.  
Verwenden Sie Get-Command ConvertTo-PowershaiContext* oder Get-PowershaiContextFormatters, um die Liste abzurufen!

Da es sich bei den nativen Context Formattern nur um Powershell-Funktionen handelt, können Sie Get-Help Name verwenden, um weitere Details zu erhalten.

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatContextFormatter [[-ChatId] <Object>] [[-Func] <Object>] [[-Params] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Func
Name der Powershell-Funktion
Verwenden Sie den Befehl Get-PowershaiContextFormatters, um die Liste anzuzeigen

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Str
Accept pipeline input: false
Accept wildcard characters: false
```

### -Params

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




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
