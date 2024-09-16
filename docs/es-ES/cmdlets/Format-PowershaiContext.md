---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Format-PowershaiContext

## SYNOPSIS <!--!= @#Synop !-->
Formata um objeto para ser injetado no contexto de uma mensagem enviada em um Powershai Chat

## DESCRIPTION <!--!= @#Desc !-->
Dado que os LLMs processam apenas strings, os objetos passados no contexto precisam ser convertidos para um formato em string, antes de serem injetados no prompt.
E, como existem várias representações de um objeto em string, o Powershai permite que o usuário tenha total controle sobre isso.  

Sempre que um objeto precisar ser injetado no prompt, quando invocado com Send-PowershaAIChat, via pipeline ou parâmetro Contexto, este cmdlet será invocado.
Este cmdlet é responsável por transformar este objeto em string, independente do objeto, seja array, hashtable, customizado, etc.  

Ele faz isso invocando a função de formatter configurada usando Set-PowershaiChatContextFormatter
No geral, você não precisa invocar essa funções diretamente, mas pode querer invocar quando quiser fazer algum teste!

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
Sobrescrever a função a ser invocada. Se não especificado usa o default do chat.

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




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
