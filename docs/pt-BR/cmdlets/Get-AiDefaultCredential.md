---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiDefaultCredential

## SYNOPSIS <!--!= @#Synop !-->
Obtém a credencial default do provider atual!

## DESCRIPTION <!--!= @#Desc !-->
Obtém a credencial default. 
Este cmdlet deve ser usado primordialmente pelos providers, quando precisarem se autenticar. 
Porém, ele é exporo publicamente para permitir que o usuário pode checar as credenciais ativas e fazer um mínimo de troubleshooting.

O cmdlet vai obter a credential default a partir do que foi definido pelo usuario e também checando umas das variáveis de ambiente, se suportados pelo provider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiDefaultCredential [-IgnoreNotExists] [[-MigrateScript] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -IgnoreNotExists
Se nãoe existir, ignora, ao invés de resultar em erro!!

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

### -MigrateScript
Script para migrar credenciais existentes.
Usado exclusivamente pelos providers. 
Cada provider pode especificar um script que deve retornar objetos AiCredential criado com NewAiCredential.

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