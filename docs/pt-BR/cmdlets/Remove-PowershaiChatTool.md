---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Remove uma tool definitivamente!

## SYNTAX <!--!= @#Syntax !-->

```
Remove-PowershaiChatTool [[-tool] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
Nome do comando, script, funcoes que foi previamente adicioonado como tool.
Se for um arquivo .ps1, trata como um script, a menos que -Force command é usado.
Você pode usar o resultado de Get-PowershaiChatTool via pipe para este comando, que ele irá reconhecer
Ao enviar o objeto retornado, todos os demais parâmetros são ignorados.

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
Força tratar tool como um comando, quando é uma string

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
Chat de onde remover

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
Remover da lista global, se a tool foi adicionada previamente como global

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