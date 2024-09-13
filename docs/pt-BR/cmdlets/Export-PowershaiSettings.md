---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Export-PowershaiSettings

## SYNOPSIS
Exporta as configurações da sessão atual para um arquivo, criptografado por uma senha

## SYNTAX

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## DESCRIPTION
Este cmdlet é útil para salvar configurações, como os Tokens, de maneira segura.
 
Ele solicia uma senha e usa ela para criar um hash e criptografar os dados de configuração da sessão em AES256.
 

As configurações exportadas são todas aquelas definidas na variável $POWERSHAI_SETTINGS.
 
Essa variável é uma hashtable contendo todos os dados configurados pelos providers, o que inclui os tokens.
 

Por padrão, os chats não são exportados devido a quantidade de dados envolvidos, o que pode deixar o arquivo muito grande!

O arquivo exportado é salvo em um diretório criado automaticamente, por padrão, na home do usuário ($HOME).
 
Os objetos são exportados via Serialization, que é o mesmo método usado por Export-CliXml.
 

Os dados são exportados em um formato próprio que pode ser importado apenas com Import-PowershaiSettings e informando a mesma senha.
 

Uma vez que o PowershAI não faz um export automático, é recomendo invocar esse comando comando sempre que houver alteração de configuração, como a inclusão de novos tokens.
 

O diretório de export pode ser qualquer caminho válido, incluindo cloud drives como OneDrive,Dropbox, etc.
 

Este comando foi criado com o intuito de ser interativo, isto é, precisa da entrada do usuário em teclado.

## EXAMPLES

### EXAMPLE 1
```
Export-PowershaiSettings
```

Exporta com as configurações padrões!

### EXAMPLE 2
```
Export-PowershaiSettings -Chat
```

Exporta incluindo os chats!

### EXAMPLE 3
```
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
```

PS\> Export-PowershaiSettings

	Exporta para um diretório no OneDrive.

## PARAMETERS

### -ExportDir
Diretório de export 
Por Padrão, é um diretorio chamado .powershai no profile do usuário, mas pode especificar a variável de ambiente POWERSHAI_EXPORT_DIR para alterar.

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

### -Chats
Se especificado, inclui os chats no export 
Todos os chats serão exportados

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
