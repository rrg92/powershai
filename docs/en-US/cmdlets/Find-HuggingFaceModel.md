---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Find-HuggingFaceModel

## SYNOPSIS <!--!= @#Synop !-->
Search for a specific model in the hub!

## DESCRIPTION <!--!= @#Desc !-->
Based on https://huggingface.co/docs/hub/en/api#get-apimodels

## SYNTAX <!--!= @#Syntax !-->

```
Find-HuggingFaceModel [[-search] <Object>] [[-filter] <Object>] [[-author] <Object>] [[-RawParams] <Object>] [[-limit] <Object>] [[-sort] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -search
search in the model name

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

### -filter
filter on tags

```yml
Parameter Set: (All)
Type: Object
Aliases: tags
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -author
filter specific authors

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

### -RawParams
overrides parameters directly in the hub API!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -limit
limit the search

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 100
Accept pipeline input: false
Accept wildcard characters: false
```

### -sort
sort by a specific property

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 6
Default Value: downloads
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
