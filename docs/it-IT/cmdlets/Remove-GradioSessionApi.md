---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Rimuovi le chiamate api dall'elenco interno della sessione

## DESCRIPTION <!--!= @#Desc !-->
Questo cmdlet aiuta a rimuovere gli eventi generati da Invoke-GradioSessionApi dall'elenco interno delle chiamate. 
Normalmente, vuoi rimuovere gli eventi che hai già elaborato, passando l'ID diretto.  
Ma, questo cmdlet ti consente di eseguire diversi tipi di rimozione, inclusi gli eventi non elaborati.  
Fai attenzione, perché, una volta che un evento viene rimosso dall'elenco, anche i dati associati a esso vengono rimossi.  
A meno che tu non abbia fatto una copia dell'evento (o dei dati risultanti) in un'altra variabile, non sarai più in grado di recuperare queste informazioni.  

La rimozione degli eventi è anche utile per aiutare a liberare la memoria consumata, che, a seconda della quantità di eventi e dati, può essere alta.

## SYNTAX <!--!= @#Syntax !-->

```
Remove-GradioSessionApi [[-Target] <Object>] [-Force] [-Elegible] [[-session] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Target
Specifica l'evento, o gli eventi, da rimuovere
L'ID può anche essere uno di questi valori speciali:
	clean 	- Rimuove solo le chiamate che sono già state completate!
  all 	- Rimuove tutto, inclusi quelli non completati!

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

### -Force
Per impostazione predefinita, vengono rimossi solo gli eventi passati con stato "completato"!
Usa -Force per rimuovere indipendentemente dallo stato!

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

### -Elegible
Non esegue alcuna rimozione, ma restituisce i candidati!

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

### -session
ID della sessione

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -WhatIf

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: wi
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Confirm

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: cf
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
