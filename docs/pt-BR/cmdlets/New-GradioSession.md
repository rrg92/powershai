---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# New-GradioSession

## SYNOPSIS
Cria uma nova sessão Gradio.

## SYNTAX

```
New-GradioSession [[-AppUrl] <Object>] [[-Name] <Object>] [[-DownloadPath] <Object>] [-Force]
 [<CommonParameters>]
```

## DESCRIPTION
Uma Sessions representa uma conexão para uma app Gradio.
 
Imagina que uma session seja como se fosse uma aba do browser aberto conectado em uma determinada app gradio.
 
Os arquivos enviados, chamadas feitas, logins, são todas gravas nesta session.

Este cmndlet retorna um objeto que chamamos de "GradioSesison".
 
Este objeto pode ser usado em outros commandlets que dependem de session (e pode ser definido uma session ativa, que todos os cmdlets usam por padrão se não especificado).
 

Toda session tem um nome que a identifica unicamente.
Se não informado pelo usuário, será criado autoamticamente com base na URL da app.
 
Não podem existir 2 sessions com o mesmo nome.

Ao criar um session, este cmdlet salva esta session em um repositorio interno de sessions.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AppUrl
Url da app

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

### -Name
Nome unico que identifica esta sessao!

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

### -DownloadPath
Diretório onde fazer o donwload dos arqiovpos

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Force recreate

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
