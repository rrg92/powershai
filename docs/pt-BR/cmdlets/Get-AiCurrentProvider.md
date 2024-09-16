---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiCurrentProvider

## SYNOPSIS <!--!= @#Synop !-->
Obtém o provider ativo

## DESCRIPTION <!--!= @#Desc !-->
Retorna o objeto que representa o provider ativo.  
Os providers são implementados como objetos e ficam armazenados na memória da sessão, em uma variável global.  
Esta função retorna o provider ativo, que foi definido com o comando Set-AiProvider.

O objeto retorando é uma hashtable contendo todos os campos do provider.  
Este comando é comumente usado pelos providers para obter o nome do provider ativo.  

O parâmetro -ContextProvider retorna o provider atual onde o script está rodando.  
Se estiver rodando em um script de um provider, ele vai retornar aquele provider, ao invés do provider definido com Set-AiProvider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
Se habilitado, usa o provider de contexto, isto é, se o código está rodando em um arquivo no diretorio de um provider, assume este provider.
Caso contrario, obtem o provider habilitado atualmente.

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