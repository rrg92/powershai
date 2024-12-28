---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiEmbeddings

## SYNOPSIS <!--!= @#Synop !-->
Gets embeddings from one or more text inputs!

## DESCRIPTION <!--!= @#Desc !-->
This function gets embeddings using an embedding-supported model!

## FOR PROVIDERS

Providers who wish to export this functionality must implement the GetEmbeddings interface.
Expected result:

an array where each item is an object containing:

- embeddings: the generated embedding.
- text: the original text, if the include text parameter was informed.

The embedding must be generated in the same order as the text provided!

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiEmbeddings [[-text] <String[]>] [-IncludeText] [[-model] <Object>] [[-BatchSize] <Object>] [[-dimensions] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -text
Array of texts to be generated!

```yml
Parameter Set: (All)
Type: String[]
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -IncludeText
Include the text in the response!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -model
model

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

### -BatchSize
Max embeddings to process at once!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -dimensions
Number of dimensions
If null, it will use the default of each provider!
Not every provider supports defining. If not supported, an error is thrown!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
