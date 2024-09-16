---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiHelp

## SYNOPSIS <!--!= @#Synop !-->
Usa o provider atual para ajudar a obter ajuda sobre o powershai!

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet utiliza os próprios comandos do PowershAI para ajudar o usuário a obter ajuda sobre ele mesmo.  
Basicamente, partindo da pergunta do usuário, ele monta um prompt com algumas informacoes comuns e helps basicos.  
Então, isso é enviando ao LLM em um chat.

Devido ao grande volume de dados enviandos, é recomendando usar esse comando somente com providers e modeos que aceitam mais de 128k e que sejam baratos.  
Por enquanto, este comando é experimental e funciona penas com estes modelos:
	- Openai gpt-4*
	
Internamente, ele irá criar um Powershai Chat chamado "_pwshai_help", onde manterá todo o histórico!

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -helptext
Descreva o texto de ajuda!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -command
Se quiser help de um comando específico, informe o comando aqui 
Não precisa ser somente um comando do PowershaiChat.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Recreate
Recria o chat!

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