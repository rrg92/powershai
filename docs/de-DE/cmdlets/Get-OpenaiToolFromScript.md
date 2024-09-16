---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Hilfsfunktion zum Konvertieren eines .ps1-Skripts in ein von OpenAI erwartetes Schemaformat.
Im Wesentlichen liest diese Funktion eine .ps1-Datei (oder Zeichenkette) zusammen mit ihrer Hilfedokumentation.  
Dann gibt sie ein Objekt im von OpenAI spezifizierten Format zurück, damit das Modell es aufrufen kann!

Gibt einen Hashtabelle zurück, der die folgenden Schlüssel enthält:
	functions - Die Liste der Funktionen mit ihrem aus der Datei gelesenen Code.  
				Wenn das Modell aufruft, können Sie es direkt von hier aus ausführen.
				
	tools - Liste der Tools, die beim Aufruf von OpenAI gesendet werden sollen.
	
Sie können Ihre Funktionen und Parameter dokumentieren, indem Sie der PowerShell-Dokumentation auf Kommentierungsbasis folgen:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-ScriptPath] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ScriptPath

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



<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
