---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS <!--!= @#Synop !-->
Defines the function that will be used to format the objects passed to the Send-PowershaiChat -Context parameter.

## DESCRIPTION <!--!= @#Desc !-->
When invoking Send-PowershaiChat in a pipe, or passing the -Context parameter directly, it will inject this object into the LLM prompt.
Before injecting, it must convert this object to a string.
This conversion is called "Context Formatter" here in Powershai.
The Context Formatter is a function that will take each object passed and convert it to a string to be injected into the prompt.
The function used should receive the object to be converted as the first parameter.

The remaining parameters are at your discretion. Their values can be specified using the -Params parameter of this function!

Powershai provides native context formatters.
Use Get-Command ConvertTo-PowershaiContext* or Get-PowershaiContextFormatters to get the list!

Since native context formatters are just PowerShell functions, you can use Get-Help Name to get more details.

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatContextFormatter [[-ChatId] <Object>] [[-Func] <Object>] [[-Params] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Func
PowerShell function name
Use the Get-PowershaiContextFormatters command to see the list

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Str
Accept pipeline input: false
Accept wildcard characters: false
```

### -Params

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




<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
