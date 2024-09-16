---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Format-PowershaiContext

## SYNOPSIS <!--!= @#Synop !-->
Formats an object to be injected into the context of a message sent in a Powershai Chat

## DESCRIPTION <!--!= @#Desc !-->
Given that LLMs process only strings, objects passed in the context need to be converted to a string format, before being injected into the prompt.
And, as there are several string representations of an object, Powershai allows the user to have complete control over this.  

Whenever an object needs to be injected into the prompt, when invoked with Send-PowershaAIChat, via pipeline or Context parameter, this cmdlet will be invoked.
This cmdlet is responsible for transforming this object into a string, regardless of the object, be it array, hashtable, custom, etc.  

It does this by invoking the formatter function configured using Set-PowershaiChatContextFormatter
Overall, you don't need to invoke this function directly, but you may want to invoke it when you want to do some testing!

## SYNTAX <!--!= @#Syntax !-->

```
Format-PowershaiContext [[-obj] <Object>] [[-params] <Object>] [[-func] <Object>] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -obj
Any object to be injected

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
Parameter to be passed to the formatter function

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
Override the function to be invoked. If not specified, use the chat's default.

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
Chat to operate on

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
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
