---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Enter-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
Exécute un code sous un fournisseur spécifique

## DESCRIPTION <!--!= @#Desc !-->
Avec ce cmdlet, vous pouvez exécuter des codes qui utilisent un fournisseur spécifique.  
Cela vous permet de garantir qu'un fournisseur donné sera retourné par les fonctions qui dépendent d'un fournisseur.

Par exemple:  
	Set-AiProvider openai  
	Enter-AiProvider ollama { Get-AiCurrentProvider } # Retourne ollama  
	Get-AiCurrentProvider # retourne openai  

Avec cela, vous pouvez forcer l'exécution d'un extrait de code sous un fournisseur spécifique.  
Vous pouvez combiner plusieurs Enter-AiProviders imbriqués;

	Set-AiProvider openai  
	Get-AiCurrentProvider # retourne openai  
	Enter-AiProvider ollama {  
		Get-AiCurrentProvider # Retourne ollama  
		Enter-AiProvider groq {  
			Get-AiCurrentProvider # Retourne groq  
		}
		
		Get-AiCurrentProvider # Retourne ollama  
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
_Traduit automatiquement en utilisant PowershAI et IA._
<!--PowershaiAiDocBlockEnd-->
