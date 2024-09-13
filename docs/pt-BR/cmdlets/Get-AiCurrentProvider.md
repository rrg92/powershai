---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Get-AiCurrentProvider

## SYNOPSIS
Obtém o provider ativo

## SYNTAX

```
Get-AiCurrentProvider [-ContextProvider]
```

## DESCRIPTION
Retorna o objeto que representa o provider ativo.
 
Os providers são implementados como objetos e ficam armazenados na memória da sessão, em uma variável global.
 
Esta função retorna o provider ativo, que foi definido com o comando Set-AiProvider.

O objeto retorando é uma hashtable contendo todos os campos do provider.
 
Este comando é comumente usado pelos providers para obter o nome do provider ativo.
 

O parâmetro -ContextProvider retorna o provider atual onde o script está rodando.
 
Se estiver rodando em um script de um provider, ele vai retornar aquele provider, ao invés do provider definido com Set-AiProvider.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ContextProvider
Se habilitado, usa o provider de contexto, isto é, se o código está rodando em um arquivo no diretorio de um provider, assume este provider.
Caso contrario, obtem o provider habilitado atualmente.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
