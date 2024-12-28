---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Cria uma nova call para um endpoint na session atual.

## DESCRIPTION <!--!= @#Desc !-->
Realiza uma call usando a API do Gradio, em um endpoint especifico e passando os parâmetros desejados.  
Esta call irá gerar um GradioApiEvent (veja Send-GradioApi), que irá ser salva internamente nas configuraçoes da sessão.  
Este objeto contém tudo o que é necessário para obter o resultado da API.  

O cmdlet irá retornar um objeto do tipo SessionApiEvent contendo as seguintes propriedades:
	id - Id interno do evento gerado.
	event - O evento interno gerado. Pode ser usado diretamente com os cmdlets que manipulam eventos.
	
As sessions possuem um limite de Calls definidas.
O objetivo é impedir criar calls indefinidas de maneira que perca o controle.

Existem duas opcoes da sessao que afetam a call (podem ser alteradas com Set-GradioSession):
	- MaxCalls 
	Controla o maximo de calls que podem ser criadas
	
	- MaxCallsPolicy 
	Conrola o que fazer quando o Max for atingido.
	Valores possiveis:
		- Error 	= resulta em erro!
		- Remove 	= remove a mais antiga 
		- Warning 	= Exibe um warning, mas permite ultrpassar o limte.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>] [[-Token] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ApiName
Nome do endpoint (sem a barra inicial)

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

### -Params
Lista de parâmetros 
Se é um array, passa diretamente para a Api do Gradio 
Se é uma hashtable, monta o array com base na posição dos parâmetros retornados pelo /info

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

### -EventId
SE especificado, cria com um evento id ja existente (pode ter sido gerado fora do modulo).

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -session
Sessao

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -Token
Forçar o uso de um novo token. Se "public", então não usa nenhum token!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```