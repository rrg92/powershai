---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
Changes the current provider

## DESCRIPTION <!--!= @#Desc !-->
Providers are scripts that implement access to their respective APIs.  
Each provider has its own way of invoking APIs, data format, response schema, etc.  

Changing the provider affects certain commands that operate on the current provider, such as `Get-AiChat`, `Get-AiModels`, or Chats, such as Send-PowershaAIChat.
For more details about providers, see the about_Powershai_Providers topic.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -provider
provider name

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
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
