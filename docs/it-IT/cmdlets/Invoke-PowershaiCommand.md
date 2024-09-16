---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowershaiCommand

## SYNOPSIS <!--!= @#Synop !-->
Consente di invocare la maggior parte delle funzioni in modo compatto

## DESCRIPTION <!--!= @#Desc !-->
Questo è un semplice utilitario che consente di invocare varie funzioni in modo più abbreviato nella riga di comando.  
Si noti che non tutti i comandi potrebbero essere supportati ancora.

È meglio usarlo con l'alias pshai.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowershaiCommand [[-CommandName] <Object>] [[-RemArgs] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
pshai tools # lista le tools
```


## PARAMETERS <!--!= @#Params !-->

### -CommandName
Nome del comando

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

### -RemArgs

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
