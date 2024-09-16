---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
Actualiza el valor de un parámetro del chat de Powershai Chat.

## DESCRIPTION <!--!= @#Desc !-->
Actualiza el valor de un parámetro de un Powershai Chat.  
Si el parámetro no existe, se devuelve un error.

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatParameter [[-parameter] <Object>] [[-value] <Object>] [[-ChatId] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -parameter
Nombre del parámetro

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

### -value
Valor del parámetro

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

### -ChatId
Chat que desea actualizar. Por defecto actualiza el chat activo

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Force
Forzar actualización, incluso si el parámetro no existe en la lista de parámetros

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




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
