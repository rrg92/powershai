---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Format-PowershaiContext

## SYNOPSIS <!--!= @#Synop !-->
Formato um objeto para ser injetado no contexto de uma mensagem envianda em um Powershai Chat

## DESCRIPTION <!--!= @#Desc !-->
Dado que LLM processam apenas strings, os objetos passados no contexto precisam ser convertidos para um formato em string, antes de serem injetados no prompt.
E, como existem várias reprsentações de um objeto em string, o Powershai permite que o usuário tenha total controle sobre isso.  

Sempre que um objeto precisar ser injado no prompt, quando invocado com Send-PowershaAIChat, via ppipeline ou parâmetro Contexto, este cmdlet será invocado.
Este cmdlet é responsavel por transformar este objeto em string, independente do objeto, seja array, hashtable, customizado, etc.  

Ele faz isso invocando a função de formatter configurada usando Set-PowershaiChatContextFormatter
NO geral, você não precisa invocar essa funções diretamente, mas pode querer invocar quando quiser fazer algum teste!

## SYNTAX <!--!= @#Syntax !-->

```
Format-PowershaiContext [[-obj] <Object>] [[-params] <Object>] [[-func] <Object>] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -obj
Objeto qualquer a ser injetado

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

### -params
Parâmetro a ser passado para a função formatter

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

### -func
Sobrescrever a função ser invocada. Se não especificado usa o defualt do chat.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ChatId
Chat em qual operar

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```