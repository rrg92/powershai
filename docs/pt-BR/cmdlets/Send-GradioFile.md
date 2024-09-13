---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Send-GradioFile

## SYNOPSIS
Faz um upload de um ou mais arquivos.
Retorna um objeto no mesmo formto de gradio FileData(https://www.gradio.app/docs/gradio/filedata). 
Caso queria retornar apenas o path do arquivo no server, use o parametro -Raw.
Thanks https://www.freddyboulton.com/blog/gradio-curl and https://www.gradio.app/guides/querying-gradio-apps-with-curl

## SYNTAX

```
Send-GradioFile [[-AppUrl] <Object>] [[-Files] <Object>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AppUrl
{{ Fill AppUrl Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Files
Lista de arquivos (paths ou FileInfo)

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw
Retorna o resultado direto do servidor!

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
