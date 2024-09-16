---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
Altera o provider atual

## DESCRIPTION <!--!= @#Desc !-->
Providers são scripts que implementam o acesso à suas respectivas APIs.  
Cada provider tem sua forma de invocar APIs, formato dos dados, schema da resposta, etc.  

Ao mudar o provider, você afeta certos comandos que operam no provider atual, como `Get-AiChat`, `Get-AiModels`, ou os Chats, como Send-PowershaAIChat.
Para saber mais detalhes sobre os providers consule o tópico about_Powershai_Providers

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -provider
nome do provider

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