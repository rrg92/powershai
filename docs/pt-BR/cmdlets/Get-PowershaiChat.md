---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-PowershaiChat

## SYNOPSIS
Retorna um ou mais Chats criados com New-PowershaAIChat

## SYNTAX

```
Get-PowershaiChat [[-ChatId] <Object>] [-SetActive] [-NoError] [<CommonParameters>]
```

## DESCRIPTION
Este comando permite retornar o objeto que representa um Powershai Chat.
 
Este objeto é o objeto referenciando internamente pelos comandos que operam no Powershai Chat.
 
Apesar de certos parâmetros você poder alterar diretamente, não é recomendável que faça esta ação.
 
Prefira sempre usar a saída desse comando como entrada para os outros que comandos PowershaiChat.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ChatId
Id do chat
Nomes especiais:
	.
- Indica o proprio chat 
 	* - Indica todos os chats

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SetActive
Define o chat como ativo, quando o id especifciado não é um nome especial.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoError
Ignora erros zde validação

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
