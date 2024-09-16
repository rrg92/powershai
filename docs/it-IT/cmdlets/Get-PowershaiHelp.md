---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiHelp

## SYNOPSIS <!--!= @#Synop !-->
Utilizza il provider corrente per aiutare ad ottenere aiuto su powershai!

## DESCRIPTION <!--!= @#Desc !-->
Questo cmdlet utilizza i propri comandi di PowershAI per aiutare l'utente ad ottenere aiuto su se stesso.  
Fondamentalmente, partendo dalla domanda dell'utente, monta un prompt con alcune informazioni comuni e help di base.  
Quindi, questo viene inviato all'LLM in una chat.

A causa del grande volume di dati inviati, è consigliabile utilizzare questo comando solo con provider e modelli che accettano più di 128k e che siano economici.  
Per ora, questo comando è sperimentale e funziona solo con questi modelli:
	- Openai gpt-4*
	
Internamente, creerà una Powershai Chat chiamata "_pwshai_help", dove manterrà tutto lo storico!

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiHelp [[-helptext] <Object>] [[-command] <Object>] [-Recreate] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -helptext
Descrivi il testo di aiuto!

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

### -command
Se vuoi aiuto per un comando specifico, inserisci il comando qui 
Non deve essere solo un comando di PowershaiChat.

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

### -Recreate
Ricrea la chat!

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
