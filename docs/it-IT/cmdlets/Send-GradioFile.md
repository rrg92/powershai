---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioFile

## SYNOPSIS <!--!= @#Synop !-->
Carica uno o più file.
Restituisce un oggetto nello stesso formato di gradio FileData(https://www.gradio.app/docs/gradio/filedata). 
Se vuoi restituire solo il percorso del file sul server, usa il parametro -Raw.
Grazie https://www.freddyboulton.com/blog/gradio-curl e https://www.gradio.app/guides/querying-gradio-apps-with-curl

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
Lista di file (percorsi o FileInfo)

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
Restituisce il risultato diretto dal server!

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
