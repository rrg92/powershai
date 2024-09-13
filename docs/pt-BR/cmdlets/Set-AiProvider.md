---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Set-AiProvider

## SYNOPSIS
Altera o provider atual

## SYNTAX

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Providers são scripts que implementam o acesso à suas respectivas APIs.
 
Cada provider tem sua forma de invocar APIs, formato dos dados, schema da resposta, etc.
 

Ao mudar o provider, você afeta certos comandos que operam no provider atual, como \`Get-AiChat\`, \`Get-AiModels\`, ou os Chats, como Send-PowershaAIChat.
Para saber mais detalhes sobre os providers consule o tópico about_Powershai_Providers

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -provider
nome do provider

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
