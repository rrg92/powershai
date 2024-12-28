---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-OpenaiToolFromScript

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Função auxiliar para converter um script .ps1, ou scriptblock, em um formato de schema esperado pela OpenAI.
Basicamente, o que essa fução faz é executar o script e obter o help de todos os comandos definidos.
Então, ele retorna um objeto no formato especifiado pela OpenAI para que o modelo possa invocar!

Retorna um hashtable contendo as seguintes keys:
	functions - A lista de funções, com seu codigo lido do arquivo.  
				Quando o modelo invocar, você pode executar diretamente daqui.
				
	tools - Lista de tools, para ser enviando na chamada da OpenAI.
	
Você pode documentar suas funções e parâmetros seguindo o Comment Based Help do PowerShell:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4

## SYNTAX <!--!= @#Syntax !-->

```
Get-OpenaiToolFromScript [[-Script] <Object>] [[-Vars] <Object>] [[-JsonSchema] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Script
Arquivo .ps1 ou scriptblock!
O script será carregado em seu proprio escopo (como se fosse um modulo).
Logo, você pode não conseguir acessar certas variáveis dependneod do escopo.
Utilize -Vars para especificar quais variáveis precisa disponibilizar no script!

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

### -Vars
Especifique variáveis e seus valores para serem disponibilizadas no escopo do script!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -JsonSchema
Especifique um json schema customizado para cada funcao retronada pelo script.
Você deve especificar uma key com o nome de cada comando. O valor é uma outra hashtable onde cada key é o nome do parâmetro e o valor é o json schema desse parâmetro

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```