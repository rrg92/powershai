---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowershaiProviderInterface

## SYNOPSIS <!--!= @#Synop !-->


## DESCRIPTION <!--!= @#Desc !-->
Invoca as implementações das interfaces de um provider provider!
O PowershAI espera que certas funções sejam implementandas pelos providers.  

Por exemplo, a função Chat é usada quando invocamos o Get-AiChat.  
Estas funções devem ser implementadas para prover a funcionalidade de maneira padrão.  
Essas funções são implementadas usando o nome do provider, por exemplo: openai_Chat.  

O Powershai usa esta função para invocar as funcoes implementadas pelo powershai. Ela atua como um wrapper e facilitado e trata cenários comuns a todas essas invocações.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowershaiProviderInterface [[-FuncName] <Object>] [[-FuncParams] <Object>] [-Ignore] [-CheckExists] [[-ProviderName] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -FuncName

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

### -FuncParams

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

### -Ignore

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

### -CheckExists

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

### -ProviderName

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