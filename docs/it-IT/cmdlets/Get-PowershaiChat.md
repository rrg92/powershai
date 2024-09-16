---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Restituisce uno o più Chat creati con New-PowershaAIChat

## DESCRIPTION <!--!= @#Desc !-->
Questo comando consente di restituire l'oggetto che rappresenta un Powershai Chat.  
Questo oggetto è l'oggetto a cui fanno riferimento internamente i comandi che operano nel Powershai Chat.  
Anche se alcuni parametri possono essere modificati direttamente, non è consigliabile farlo.  
È sempre preferibile utilizzare l'output di questo comando come input per gli altri comandi PowershaiChat.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChat [[-ChatId] <Object>] [-SetActive] [-NoError] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
Id della chat
Nomi speciali:
	. - Indica la chat stessa
 	* - Indica tutte le chat

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

### -SetActive
Definisce la chat come attiva, quando l'id specificato non è un nome speciale.

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

### -NoError
Ignora gli errori di validazione

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
