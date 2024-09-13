---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Import-PowershaiSettings

## SYNOPSIS
Importa uma configuração exportada com Export-PowershaiSettings

## SYNTAX

```
Import-PowershaiSettings [[-ExportDir] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Este cmdlet é o pair do Export-PowershaiSettings, e como o nome indica, ele importa os dados que foram exportados.
 
Você deve garantir que a mesma senha e o mesmo arquivo são passados.
 

IMPORTANTE: Este comando sobscreverá todos os dados configurados na sessão.
Só execute ele se tiver certeza absoluta que nenhum dado configurado previamente pode ser perdido.
Por exemplo, alguma API Token nova gerada recentemente.

Se você estivesse especifciado um caminho de export diferente do padrão, usando a variável POWERSHAI_EXPORT_DIR, deve usa ro mesmo aqui.

O processo de import valida alguns headers para garantir que o dado foi descriptografado corretamente.
 
Se a senha informanda estiver incorreta, os hashs não vão ser iguais, e ele irá disparar o erro de senha incorreta.

Se, por outro lado, um erro de formado invalido de arquivo for exibido, significa que houve alguma corrupção no proesso de import ou é um bug deste comando.
 
Neste caso, você pode abrir uma issue no github relatando o problema.

## EXAMPLES

### EXAMPLE 1
```
Import-PowershaiSettings
```

Importa as configurações do diretório padrão.

### EXAMPLE 2
```
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
```

PS\> Import-PowershaiSettings

	Importa as configurações que foram exportadas para um diretório alternativo (one drive).

## PARAMETERS

### -ExportDir
{{ Fill ExportDir Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $Env:POWERSHAI_EXPORT_DIR
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
