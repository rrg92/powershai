---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Enter-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
Ejecuta un código bajo un proveedor específico

## DESCRIPTION <!--!= @#Desc !-->
Con este cmdlet, puedes ejecutar códigos que utilizan un proveedor específico.  
Esto te permite garantizar que un determinado proveedor será devuelto por las funciones que dependen de un proveedor.

Por ejemplo:
	Set-AiProvider openai 
	Enter-AiProvider ollama { Get-AiCurrentProvider } # Devuelve ollama
	Get-AiCurrentProvider # devuelve openai 
	
Con esto, puedes forzar la ejecución de un fragmento de código bajo un proveedor específico.  
Puedes combinar varios Enter-AiProviders anidados;

	Set-AiProvider openai 
	Get-AiCurrentProvider # devuelve openai 
	Enter-AiProvider ollama { 
		Get-AiCurrentProvider # Devuelve ollama
		Enter-AiProvider groq {
			Get-AiCurrentProvider # Devuelve groq
		}
		
		Get-AiCurrentProvider # Devuelve ollama
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


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA._
<!--PowershaiAiDocBlockEnd-->
