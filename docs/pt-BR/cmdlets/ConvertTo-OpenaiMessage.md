---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiMessage

## SYNOPSIS <!--!= @#Synop !-->
Converte array de string e objetos para um formato de mensagens padrão da OpenAI!

## DESCRIPTION <!--!= @#Desc !-->
Voce pode passar uma array misto onde cada item pode ser uma string ou um objeto.
Se for uma string, pode iniciar com o prefixo s, u ou a, que significa, respestivamente, system, user ou assistant.
Se for um objeto, ele adicionado diretamente ao array resultanete.

Veja: https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiMessage [[-prompt] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
ConvertTo-OpenaiMessage "Isso é um texto",@{role:"assistant";content="Resposta assistant"}, "s:Msg system"
```


## PARAMETERS <!--!= @#Params !-->

### -prompt

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