---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-PowershaiHelp

## SYNOPSIS
Usa o provider atual para ajudar a obter ajuda sobre o powershai!

## SYNTAX

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## DESCRIPTION
Este cmdlet utiliza os próprios comandos do PowershAI para ajudar o usuário a obter ajuda sobre ele mesmo.
 
Basicamente, partindo da pergunta do usuário, ele monta um prompt com algumas informacoes comuns e helps basicos.
 
Então, isso é enviando ao LLM em um chat.

Devido ao grande volume de dados enviandos, é recomendando usar esse comando somente com providers e modeos que aceitam mais de 128k e que sejam baratos.
 
Por enquanto, este comando é experimental e funciona penas com estes modelos:
	- Openai gpt-4*
	
Internamente, ele irá criar um Powershai Chat chamado "_pwshai_help", onde manterá todo o histórico!

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -helptext
Descreva o texto de ajuda!

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

### -command
Se quiser help de um comando específico, informe o comando aqui 
Não precisa ser somente um comando do PowershaiChat.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recreate
Recria o chat!

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
