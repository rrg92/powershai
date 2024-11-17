---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Update-GradioSessionApiResult

## SYNOPSIS <!--!= @#Synop !-->
Atualiza o retorno de uma call gerado como Invoke-GradioSessionApi

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet segue o mesmo princípcio dos seus equivalentes em Send-GradioApi e Update-GradioApiResult.
Porém ele funciona apenas para os eventos gerados em uma sessão específica.
Retorna o próprio evento para que possa ser usado com outos cmdlets que deendam do evento atualizado!

## SYNTAX <!--!= @#Syntax !-->

```
Update-GradioSessionApiResult [[-Id] <Object>] [-NoOutput] [[-MaxHeartBeats] <Object>] [[-session] <Object>] [-History] 
[<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Id
Id do evento, retornado por  Invoke-GradioSessionApi ou o próprio objeto retornado.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -NoOutput
Não jogar o resultado de volta pro output!

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

### -MaxHeartBeats
Max hearbeats consecutivos.

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

### -session
Id da sessão

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -History
Adiciona o eventos no histórico de eventos do objeto GradioApiEvent informado em -Id

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