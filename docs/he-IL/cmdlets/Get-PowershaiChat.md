---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Retorna um ou mais Chats criados com New-PowershaAIChat

## DESCRIPTION <!--!= @#Desc !-->
Este comando permite retornar o objeto que representa um Powershai Chat.  
Este objeto é o objeto referenciando internamente pelos comandos que operam no Powershai Chat.  
Apesar de certos parâmetros você poder alterar diretamente, não é recomendável que faça esta ação.  
Prefira sempre usar a saída desse comando como entrada para os outros que comandos PowershaiChat.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChat [[-ChatId] <Object>] [-SetActive] [-NoError] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Id do chat
Nomes especiais:
	. - Indica o proprio chat 
 	* - Indica todos os chats

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

### -SetActive
Define o chat como ativo, quando o id especifciado não é um nome especial.

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

### -NoError
Ignora erros zde validação

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




<!--PowershaiAiDocBlockStart-->
_תרגם אוטומטית באמצעות PowershAI ובינה מלאכותית. 
_
<!--PowershaiAiDocBlockEnd-->
