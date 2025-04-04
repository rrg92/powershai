﻿---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-OllamaApi

## SYNOPSIS <!--!= @#Synop !-->
Base para invocar a API do ollama (parte da api que nao é compativel com a openai)

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-OllamaApi [[-endpoint] <Object>] [[-body] <Object>] [[-method] <Object>] [[-token] <Object>] [[-StreamCallback] <Object>] [-GetRawResp] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -endpoint

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

### -body

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

### -method

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: POST
Accept pipeline input: false
Accept wildcard characters: false
```

### -token

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: $Env:OLLAMA_API_KEY
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
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -GetRawResp

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