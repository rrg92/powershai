---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Clear-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Elimina elementos de un chat!

## DESCRIPTION <!--!= @#Desc !-->
Elimina elementos específico de un chat.  
Útil para liberar recursos, o quitar el vicio del llm debido al historial.

## SYNTAX <!--!= @#Syntax !-->

```
Clear-PowershaiChat [-History] [-Context] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -History
Elimina todo el historial

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

### -Context
Elimina el contexto 
Id del chat. Por defecto: activo.

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




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
