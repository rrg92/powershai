---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GoogleGenerateContent

## SYNOPSIS <!--!= @#Synop !-->
Endpoint: https://ai.google.dev/api/generate-content
Stream: https://ai.google.dev/api/generate-content#method:-models.streamgeneratecontent

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GoogleGenerateContent [[-messages] <Object>] [[-model] <Object>] [[-StreamCallback] <Object>] [[-RawParams] <Object>] [[-Tools] 
<Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -messages

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -model

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: gemini-1.5-flash
Accept pipeline input: false
Accept wildcard characters: false
```

### -StreamCallback

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

### -Tools

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```