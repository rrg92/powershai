---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioFile

## SYNOPSIS <!--!= @#Synop !-->
Sube uno o más archivos.
Devuelve un objeto en el mismo formato que gradio FileData(https://www.gradio.app/docs/gradio/filedata). 
Si deseas devolver solo la ruta del archivo en el servidor, usa el parámetro -Raw.
Gracias https://www.freddyboulton.com/blog/gradio-curl y https://www.gradio.app/guides/querying-gradio-apps-with-curl

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
Lista de archivos (rutas o FileInfo)

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
Devuelve el resultado directo del servidor!

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
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
