---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Rimuovi uno strumento definitivamente!

## SYNTAX <!--!= @#Syntax !-->

```
Remove-PowershaiChatTool [[-tool] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -tool
Nome del comando, script, funzioni che è stato precedentemente aggiunto come strumento.
Se è un file .ps1, tratta come uno script, a meno che -Force command non venga utilizzato.
Puoi usare il risultato di Get-PowershaiChatTool tramite pipe per questo comando, che lo riconoscerà.
Quando invii l'oggetto restituito, tutti gli altri parametri vengono ignorati.

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

### -ForceCommand
Forza il trattamento dello strumento come un comando, quando è una stringa

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

### -ChatId
Chat da cui rimuovere

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

### -global
Rimuovi dall'elenco globale, se lo strumento è stato aggiunto in precedenza come globale

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
