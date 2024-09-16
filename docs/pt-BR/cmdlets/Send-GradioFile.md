---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioFile

## SYNOPSIS <!--!= @#Synop !-->
Faz um upload de um ou mais arquivos.
Retorna um objeto no mesmo formto de gradio FileData(https://www.gradio.app/docs/gradio/filedata). 
Caso queria retornar apenas o path do arquivo no server, use o parametro -Raw.
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
Lista de arquivos (paths ou FileInfo)

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
Retorna o resultado direto do servidor!

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