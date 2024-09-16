---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Define algumas opções da session.

## SYNTAX <!--!= @#Syntax !-->

```
Set-GradioSession [[-Session] <Object>] [-Default] [[-MaxCalls] <Object>] [[-MaxCallsPolicy] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Session
Sessão Gradio

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Default
Define a session como a default

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

### -MaxCalls
Configurar o maximo de calls. Veja mais em Invoke-GradioSessionApi

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

### -MaxCallsPolicy
Configurar a policy de max calls Veja mais em Invoke-GradioSessionApi

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