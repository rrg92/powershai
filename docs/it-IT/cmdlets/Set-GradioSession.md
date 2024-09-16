---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Definisci alcune opzioni della sessione.

## SYNTAX <!--!= @#Syntax !-->

```
Set-GradioSession [[-Session] <Object>] [-Default] [[-MaxCalls] <Object>] [[-MaxCallsPolicy] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Session
Sessione Gradio

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
Definisci la sessione come predefinita

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
Configura il numero massimo di chiamate. Vedi ulteriori informazioni in Invoke-GradioSessionApi

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
Configura la policy del numero massimo di chiamate. Vedi ulteriori informazioni in Invoke-GradioSessionApi

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
