---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# ConvertTo-OpenaiMessage

## SYNOPSIS
Converte array de string e objetos para um formato de mensagens padrão da OpenAI!

## SYNTAX

```
ConvertTo-OpenaiMessage [[-prompt] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Voce pode passar uma array misto onde cada item pode ser uma string ou um objeto.
Se for uma string, pode iniciar com o prefixo s, u ou a, que significa, respestivamente, system, user ou assistant.
Se for um objeto, ele adicionado diretamente ao array resultanete.

Veja: https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-OpenaiMessage "Isso é um texto",@{role:"assistant";content="Resposta assistant"}, "s:Msg system"
```

Retorna o seguinte array:
	
	@{ role = "user", content = "Isso é um texto" }
	@{role:"assistant";content="Resposta assistant"}
	@{ role = "system", content = "Msg system" }

## PARAMETERS

### -prompt
{{ Fill prompt Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
