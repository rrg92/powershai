---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
Actualiza el retorno de una llamada generada como Invoke-GradioSessionApi

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet sigue el mismo principio que sus equivalentes en Send-GradioApi y Update-GradioApiResult.
Sin embargo, funciona solo para los eventos generados en una sesión específica.
¡Devuelve el evento en sí para que pueda usarse con otros cmdlets que exigen el evento actualizado!

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Id
Id del evento, devuelto por Invoke-GradioSessionApi o el propio objeto devuelto.

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

### -NoOutput
¡No devuelve el resultado al output!

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

### -MaxHeartBeats
Max hearbeats consecutivos.

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

### -session
Id de la sesión

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

### -History
Añade los eventos al historial de eventos del objeto GradioApiEvent informado en -Id

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
