---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultCredentialPolicy

## SYNOPSIS <!--!= @#Synop !-->
Define como Get-AiDefaultCredential irá considerar trazer a credential default

## DESCRIPTION <!--!= @#Desc !-->
Get-AiDefaultCredential pode ter credenciais conflitantes: Múltiplas credenciais disponíveis como default. 
Se o comando não pode seguramente determinar a default, ele então usa a Policy definida aqui para deterinar o que fazer.  

O objetivo é fazer com que o usuário tenha plena ciência de qual credencial está sendo escohida ou que, pelo menos, ele saiba que múltiplas credenciais podem estar disponíveis para escolha e qualquer uma delas pode ser escolhida.

Por exemplo, quando se habilita credenciais via variável de ambiente, e quando há uma credencial defindia com Set-AiCredential, duas credenciais default serão possíveis: a defindia via environment e a com Set-AiCredential.  
O usuário pode ter, de maneira equivocada, ter definido uma credencial via variável de ambiente e esqueceu que  havia uma definida via cmdlet.  
Nesse cenário, o powershai não pode seguramente determinar qual credential é válida. Então, ele usa a policy para determinr.

EStas policies são mantidas somente na sessão atual, e não são exportadas, ou seja, em scripts, o usuário deve sempre usar esse comando para definir o comportamento esperado. Isso é uma forma do usuário dar ciência (um ack) de que entende e aceita a política padrão.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultCredentialPolicy [[-Policy] <String>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Policy
Define a policita. Valores:
	error 		- dispara um erro se múltipla credenciais estão definidas 
	warning 	- Retorna a primeira credencial da lista, e emite um warning 
	first 		- Retorna a primeira, sem emitir warnings
	script 		- Retorna a primeira resultante de um filtro com base em um script. O objeto $_ apontará para o objeto AiCredentialSource (Veja Get-AiDefaultCredential para detalhes deste objeto). Especifique o script no argumento seguinte.

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```