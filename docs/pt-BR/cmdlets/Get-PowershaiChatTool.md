---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Obtéma a list de tools atuais.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatTool [[-tool] <Object>] [-Enabled] [[-ChatId] <Object>] [-global] [-ForceCommand] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
obter especifico pelo nome ou o proprio objeto!
Se terminar como um .ps1, trata como script, a menos que ForceCommand seja usado!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: *
Accept pipeline input: false
Accept wildcard characters: false
```

### -Enabled
listar somente as tools habilitadas

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
Chat de origem

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
Quando obtendo uma tool específica, procurar na lista de tools globais.

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

### -ForceCommand
Trata tool como um command!

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