---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioFile

## SYNOPSIS <!--!= @#Synop !-->
Lädt eine oder mehrere Dateien hoch.
Gibt ein Objekt im gleichen Format wie Gradio FileData(https://www.gradio.app/docs/gradio/filedata) zurück.
Wenn Sie nur den Pfad der Datei auf dem Server zurückgeben möchten, verwenden Sie den Parameter -Raw.
Thanks https://www.freddyboulton.com/blog/gradio-curl and https://www.gradio.app/guides/querying-gradio-apps-with-curl

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioFile [[-AppUrl] <Object>] [[-Files] <Object>] [-Raw] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl

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

### -Files
Liste von Dateien (Pfade oder FileInfo)

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

### -Raw
Gibt das direkte Ergebnis vom Server zurück!

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
