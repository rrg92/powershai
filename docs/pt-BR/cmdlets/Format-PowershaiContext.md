---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Format-PowershaiContext

## SYNOPSIS
Formato um objeto para ser injetado no contexto de uma mensagem envianda em um Powershai Chat

## SYNTAX

```
Format-PowershaiContext [[-obj] <Object>] [[-params] <Object>] [[-func] <Object>] [[-ChatId] <Object>]
 [<CommonParameters>]
```

## DESCRIPTION
Dado que LLM processam apenas strings, os objetos passados no contexto precisam ser convertidos para um formato em string, antes de serem injetados no prompt.
E, como existem várias reprsentações de um objeto em string, o Powershai permite que o usuário tenha total controle sobre isso.
 

Sempre que um objeto precisar ser injado no prompt, quando invocado com Send-PowershaAIChat, via ppipeline ou parâmetro Contexto, este cmdlet será invocado.
Este cmdlet é responsavel por transformar este objeto em string, independente do objeto, seja array, hashtable, customizado, etc.
 

Ele faz isso invocando a função de formatter configurada usando Set-PowershaiChatContextFormatter
NO geral, você não precisa invocar essa funções diretamente, mas pode querer invocar quando quiser fazer algum teste!

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -obj
Objeto qualquer a ser injetado

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

### -params
Parâmetro a ser passado para a função formatter

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

### -func
Sobrescrever a função ser invocada.
Se não especificado usa o defualt do chat.

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

### -ChatId
Chat em qual operar

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
