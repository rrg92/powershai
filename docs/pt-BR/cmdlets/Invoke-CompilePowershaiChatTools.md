---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-CompilePowershaiChatTools

## SYNOPSIS <!--!= @#Synop !-->
Converte todas as tools adicionadas no formato esperado pela função Invoke-AiChatTools.

## DESCRIPTION <!--!= @#Desc !-->
Obtém todas as tools cadastradas pelo usuário com New-PowershaiChatTool e compila em um único objeto para ser enviado ao LLM usando Invoke-AiChatTools.  
Este processo pode ser bem lento, dependendo da quantidade de tools adicionadas.

O cmdlet vai pecorrer todas as tools, obter o help dos comando e dos parâmetros, e converter isso em um formato que possa ser enviado em Invoke-AiChatTools
Como o PowershAI define que o mecanismo de tools deve seguir o padrão da OpenAI, a função Get-OpenaiTool* do provider OpenAI é usada.  
Estas funcões contém a lógica necessária para gerar o schema da tool calling seguindo as especificações da OpenAI.  

Este comando, itera em cada tool disponível para o chat atual e cria o que é necessário para ser enviado com Invoke-AiChatTools. 
Invoke-AiChatTools contém toda a lógica para lidar com o envio, execução e resposta do LLM.  

Basicamente, existem 2 tipos de tools que o Powershai Suporte: Script ou Comando.  
Comando é qualquer código executável pelo powershell: funções, .exe, cmdlets nativos, etc.

Scripts são simples arquivos .ps1 que definem as funções que podem ser usadas como tools.
É como se fosse um grupo de comandos.

Este comando invoca tudo o que é necessário para converter essas tools no formato padrão esperado Invoke-AiChatTools.  
Invoke-AiChatTools não sabe nada sobre chats, tools globais. Ela é uma função genérica que não depende do mecanismo de Chats criado pelo Powershai.  

Por isso, é necessário que esta função faça toda essa "tradução" das facilidades do Powershai Chat para o esperado pelo Invoke-AiChatTools.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-CompilePowershaiChatTools [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Chat do qual serão obtidos as tools 
Além do chat, as tools globais serão inclusas

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```