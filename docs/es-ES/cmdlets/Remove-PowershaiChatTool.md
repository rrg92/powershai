---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Remove una herramienta definitivamente!

## SYNTAX <!--!= @#Syntax !-->

```
Remove-PowershaiChatTool [[-tool] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
Nombre del comando, script, funciones que fueron previamente añadidas como herramienta.
Si es un archivo .ps1, se trata como un script, a menos que -Force command se use.
Puedes usar el resultado de Get-PowershaiChatTool vía pipe para este comando, que lo reconocerá
Al enviar el objeto retornado, todos los demás parámetros son ignorados.

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

### -ForceCommand
Fuerza a tratar la herramienta como un comando, cuando es una cadena

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
Chat de donde remover

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -global
Remover de la lista global, si la herramienta fue añadida previamente como global

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
