---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Invoke-GradioSessionApi

## SYNOPSIS
Cria uma nova call para um endpoint na session atual.

## SYNTAX

```
Invoke-GradioSessionApi [[-ApiName] <Object>] [[-Params] <Object>] [[-EventId] <Object>] [[-session] <Object>]
 [[-Token] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Realiza uma call usando a API do Gradio, em um endpoint especifico e passando os parâmetros desejados.
 
Esta call irá gerar um GradioApiEvent (veja Send-GradioApi), que irá ser salva internamente nas configuraçoes da sessão.
 
Este objeto contém tudo o que é necessário para obter o resultado da API.
 

O cmdlet irá retornar um objeto do tipo SessionApiEvent contendo as seguintes propriedades:
	id - Id interno do evento gerado.
	event - O evento interno gerado.
Pode ser usado diretamente com os cmdlets que manipulam eventos.
	
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

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ApiName
Nome do endpoint (sem a barra inicial)

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

### -Params
Lista de parâmetros 
Se é um array, passa diretamente para a Api do Gradio 
Se é uma hashtable, monta o array com base na posição dos parâmetros retornados pelo /info

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventId
SE especificado, cria com um evento id ja existente (pode ter sido gerado fora do modulo).

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -session
Sessao

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: .
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Token
Forçar o uso de um novo token.
Se "public", então não usa nenhum token!

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
