---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiMessage

## SYNOPSIS <!--!= @#Synop !-->
Converte array di stringhe e oggetti in un formato di messaggi standard per OpenAI!

## DESCRIPTION <!--!= @#Desc !-->
Puoi passare un array misto in cui ogni elemento può essere una stringa o un oggetto.
Se è una stringa, può iniziare con il prefisso s, u o a, che significa rispettivamente sistema, utente o assistente.
Se è un oggetto, viene aggiunto direttamente all'array risultante.

Vedi: https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiMessage [[-prompt] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
ConvertTo-OpenaiMessage "Questo è un testo",@{role:"assistant";content="Risposta assistente"}, "s:Msg system"
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


<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
