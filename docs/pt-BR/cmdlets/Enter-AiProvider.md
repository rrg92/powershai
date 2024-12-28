---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Enter-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
Executa um código sob um provider específico

## DESCRIPTION <!--!= @#Desc !-->
Com este cmdlet, você pode execuar códigos que usam um provider específico.
Isso permite que você garanta que um determinado provider será retornado pelas funcoes que dependem de um provider. 

Por exemplo:
	Set-AiProvider openai 
	Enter-AiProvider ollama { Get-AiCurrentProvider } # Retorna ollama
	Get-AiCurrentProvider # retorna openai 
	
Com isso, você pode forçar a execução de um trecho de código sob um provider especifico. 
Você pode combinar város Enter-AiProviders aninhados;

	Set-AiProvider openai 
	Get-AiCurrentProvider # retorna openai 
	Enter-AiProvider ollama { 
		Get-AiCurrentProvider # Retorna ollama
		Enter-AiProvider groq {
			Get-AiCurrentProvider # Retorna groq
		}
		
		Get-AiCurrentProvider # Retorna ollama
	}

## SYNTAX <!--!= @#Syntax !-->

```
Enter-AiProvider [[-Provider] <Object>] [[-code] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Provider

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

### -code

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