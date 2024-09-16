---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Wait-HuggingFaceSpace

## SYNOPSIS <!--!= @#Synop !-->
Espera a que el espacio se inicie. Devuelve $true si se inició correctamente o $false si se agotó el tiempo de espera.

## SYNTAX <!--!= @#Syntax !-->

```
Wait-HuggingFaceSpace [[-Space] <Object>] [-timeout <Object>] [-SleepTime <Object>] [-NoStatus] [-NoStart] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Space
Filtra por un espacio específico

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -timeout
Cuántos segundos, como máximo, esperar. Si es null, entonces espera indefinidamente.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -SleepTime
Tiempo de espera hasta el próximo chequeo, en ms

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 5000
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoStatus
no imprime el estado de progreso...

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

### -NoStart
No inicia, solo espera.

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
