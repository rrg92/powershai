---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Deshabilita una herramienta (pero no la elimina). La herramienta deshabilitada no se envía al LLM.

## SYNTAX <!--!= @#Syntax !-->

### Enable
```
Set-PowershaiChatTool [-tool <Object>] [-Enable] [-ForceCommand] [-ChatId <Object>] [-Global] [<CommonParameters>]
```

### Disable
```
Set-PowershaiChatTool [-tool <Object>] [-Disable] [-ForceCommand] [-ChatId <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
Nombre de la herramienta (igual que en Add-PowershaiChatTool) o mediante tubería el resultado de Get-PowershaiChatTool

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Enable
habilita la herramienta.

```yml
Parameter Set: Enable
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -Disable
deshabilita la herramienta.

```yml
Parameter Set: Disable
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -ForceCommand
Si se indica, y la herramienta es un nombre, ¡fuerza que se trate como script!

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
Chat en el que está la herramienta

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Global
Busca la herramienta en la lista global de herramientas

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
