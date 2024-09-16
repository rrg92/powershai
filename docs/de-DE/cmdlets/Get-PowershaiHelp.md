---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiHelp

## SYNOPSIS <!--!= @#Synop !-->
Verwendet den aktuellen Provider, um bei der Suche nach Hilfe zum Powershai zu helfen!

## DESCRIPTION <!--!= @#Desc !-->
Dieser Cmdlet verwendet die eigenen Befehle des PowershAI, um dem Benutzer zu helfen, Hilfe zu ihm selbst zu erhalten.  
Im Wesentlichen erstellt es aus der Frage des Benutzers eine Eingabeaufforderung mit einigen gängigen Informationen und grundlegenden Hilfestellungen.  
Dann wird dies in einem Chat an das LLM gesendet.

Aufgrund des großen Datenvolumens, das gesendet wird, wird empfohlen, diesen Befehl nur mit Providern und Modellen zu verwenden, die mehr als 128 KB akzeptieren und günstig sind.  
Derzeit ist dieser Befehl experimentell und funktioniert nur mit diesen Modellen:
	- Openai gpt-4*
	
Intern erstellt er einen Powershai-Chat namens "_pwshai_help", in dem der gesamte Verlauf gespeichert wird!

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -helptext
Beschreiben Sie den Hilfetext!

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

### -command
Wenn Sie Hilfe zu einem bestimmten Befehl benötigen, geben Sie den Befehl hier an.
Dies muss nicht nur ein PowershaiChat-Befehl sein.

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

### -Recreate
Erstellt den Chat neu!

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
