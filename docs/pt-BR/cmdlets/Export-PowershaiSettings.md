---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Export-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Exporta as configurações da sessão atual para um arquivo, criptografado por uma senha

## DESCRIPTION <!--!= @#Desc !-->
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

## SYNTAX <!--!= @#Syntax !-->

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Exportando as configurações padrões!
```powershell
Export-PowershaiSettings
```

### Exporta tudo, incluindo os chats!
```powershell
Export-PowershaiSettings -Chat
```

### Exportando para o OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Export-PowershaiSettings
```

## PARAMETERS <!--!= @#Params !-->

### -ExportDir
Diretório de export 
Por Padrão, é um diretorio chamado .powershai no profile do usuário, mas pode especificar a variável de ambiente POWERSHAI_EXPORT_DIR para alterar.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: $Env:POWERSHAI_EXPORT_DIR
Accept pipeline input: false
Accept wildcard characters: false
```

### -Chats
Se especificado, inclui os chats no export 
Todos os chats serão exportados

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