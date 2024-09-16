---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# ConvertTo-OpenaiMessage

## SYNOPSIS <!--!= @#Synop !-->
Konvertiert ein Array von Strings und Objekten in ein OpenAI-Standard-Nachrichtenformat!

## DESCRIPTION <!--!= @#Desc !-->
Sie können ein gemischtes Array übergeben, bei dem jedes Element entweder ein String oder ein Objekt ist.
Wenn es sich um einen String handelt, kann er mit dem Präfix s, u oder a beginnen, was jeweils system, user oder assistant bedeutet.
Wenn es sich um ein Objekt handelt, wird es direkt dem resultierenden Array hinzugefügt.

Siehe: https://platform.openai.com/docs/api-reference/chat/create#chat-create-messages

## SYNTAX <!--!= @#Syntax !-->

```
ConvertTo-OpenaiMessage [[-prompt] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
ConvertTo-OpenaiMessage "Dies ist ein Text",@{role:"assistant";content="Assistant-Antwort"}, "s:System-Nachricht"
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
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
