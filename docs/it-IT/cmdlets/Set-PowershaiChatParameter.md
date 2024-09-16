---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
Aggiorna il valore di un parametro della chat di Powershai Chat.

## DESCRIPTION <!--!= @#Desc !-->
Aggiorna il valore di un parametro di una chat di Powershai Chat.  
Se il parametro non esiste, viene restituito un errore.

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatParameter [[-parameter] <Object>] [[-value] <Object>] [[-ChatId] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -parameter
Nome del parametro

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

### -value
Valore del parametro

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

### -ChatId
Chat che desideri aggiornare. Di default aggiorna la chat attiva

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

### -Force
Forza l'aggiornamento, anche se il parametro non esiste nell'elenco dei parametri

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



<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
