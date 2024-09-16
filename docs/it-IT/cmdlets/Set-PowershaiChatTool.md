---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Disabilita uno strumento (ma non lo rimuove). Uno strumento disabilitato non viene inviato all'LLM.

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
Nome dello strumento (stesso di Add-PowershaiChatTool) o tramite pipe il risultato di Get-PowershaiChatTool

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
abilita lo strumento.

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
disabilita lo strumento.

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
Se impostato, e lo strumento è un nome, lo forza a essere considerato come uno script!

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
Chat in cui si trova lo strumento

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
Cerca lo strumento nell'elenco globale degli strumenti

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
