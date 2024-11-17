---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Invia un messaggio in una chat di Powershai

## DESCRIPTION <!--!= @#Desc !-->
Questo cmdlet consente di inviare un nuovo messaggio al LLM del provider attuale.  
Per impostazione predefinita, invia nella chat attiva. Puoi sovrascrivere la chat utilizzando il parametro -Chat. Se non c'è una chat attiva, utilizzerà il default.  

Diversi parametri della chat influenzano come questo comando. Vedi il comando Get-PowershaiChatParameter per ulteriori informazioni sui parametri della chat.  
Oltre ai parametri della chat, i parametri del comando stesso possono sovrascrivere il comportamento. Per ulteriori dettagli, consulta la documentazione di ciascun parametro di questo cmdlet usando get-help.  

Per semplicità e per mantenere la linea di comando pulita, consentendo all'utente di concentrarsi di più sul prompt e sui dati, sono disponibili alcuni alias.  
Questi alias possono attivare determinati parametri.
Sono essi:
	ia|ai
		Abbreviazione di "Intelligenza Artificiale" in italiano. Questo è un alias semplice e non modifica alcun parametro. Aiuta a ridurre notevolmente la linea di comando.
	
	iat|ait
		Il stesso di Send-PowershaAIChat -Temporary
		
	io|ao
		Il stesso di Send-PowershaAIChat -Object
		
	iam|aim 
		Il stesso di Send-PowershaiChat -Screenshot 

L'utente può creare i propri alias. Ad esempio:
	Set-Alias ki ia # Definisce l'alias per il tedesco!
	Set-Alias kit iat # Definisce l'alias kit per iat, facendo comportare come iat (chat temporanea) quando si usa kit!

## SYNTAX <!--!= @#Syntax !-->

```
Send-PowershaiChat [[-prompt] <Object>] [-SystemMessages <Object>] [-context <Object>] [-ForEach] [-Json] [-Object] [-PrintContext] 
[-Forget] [-Snub] [-Temporary] [-DisableTools] [-FormatterFunc <Object>] [-FormatterParams <Object>] [-PassThru] [-Lines] 
[-ChatParamsOverride <Object>] [-RawParams <Object>] [-Screenshot] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -prompt
il prompt da inviare al modello

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

### -SystemMessages
Messaggio di sistema da includere

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```

### -context
Il contesto 
Questo parametro è da usare preferibilmente tramite pipeline.
Farà in modo che il comando metta i dati in tag <contexto></contexto> e li inietterà insieme al prompt.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -ForEach
Forza il cmdlet ad eseguire per ogni oggetto della pipeline
Per impostazione predefinita, accumula tutti gli oggetti in un array, converte l'array in una stringa e invia tutto in una sola volta al LLM.

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

### -Json
Abilita la modalità json 
in questa modalità i risultati restituiti saranno sempre un JSON.
Il modello attuale deve supportare!

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

### -Object
Modalità Oggetto!
in questa modalità la modalità JSON sarà attivata automaticamente!
Il comando non scriverà nulla sullo schermo e restituirà i risultati come un oggetto!
Che saranno rimandati nella pipeline!

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

### -PrintContext
Mostra i dati di contesto inviati al LLM prima della risposta!
È utile per debuggare cosa viene iniettato come dati nel prompt.

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

### -Forget
Non inviare le conversazioni precedenti (la cronologia del contesto), ma includere il prompt e la risposta nel contesto storico.

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

### -Snub
Ignora la risposta del LLM e non include il prompt nel contesto storico

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

### -Temporary
Non invia la cronologia e non include la risposta e il prompt.  
È lo stesso di passare -Forget e -Snub insieme.

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

### -DisableTools
Disabilita la chiamata di funzione per questa esecuzione solo!

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: NoCalls,NoTools,nt
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterFunc
Modifica il formatter del contesto per questo
Leggi di più in Format-PowershaiContext

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -FormatterParams
Parametri del formatter del contesto modificato.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PassThru
Restituisce i messaggi indietro nella pipeline, senza scrivere direttamente sullo schermo!
Questa opzione presume che l'utente sarà responsabile di dare la corretta destinazione del messaggio!
L'oggetto passato alla pipeline avrà le seguenti proprietà:
	text 			- Il testo (o estratto) del testo restituito dal modello 
	formatted		- Il testo formattato, inclusi il prompt, come se fosse scritto direttamente sullo schermo (senza colori)
	event			- L'evento. Indica l'evento che ha originato. Sono gli stessi eventi documentati in Invoke-AiChatTools
	interaction 	- L'oggetto interaction generato da Invoke-AiChatTools

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

### -Lines
Restituisce un array di righe 
Se la modalità stream è attivata, restituirà una riga alla volta!

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

### -ChatParamsOverride
Sovrascrivere i parametri della chat!
Specifica ogni opzione in hash table!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -RawParams
Specifica direttamente il valore del parametro chat RawParams!
Se specificato anche in ChatParamOverride, viene effettuata una fusione, dando priorità ai parametri specificati qui.
Il RawParams è un parametro chat che definisce parametri che saranno inviati direttamente all'API del modello!
Questi parametri sovrascriveranno i valori predefiniti calcolati da powershai!
Con ciò, l'utente ha il pieno controllo sui parametri, ma deve conoscere ogni provider!
Inoltre, ogni provider è responsabile di fornire questa implementazione e utilizzare questi parametri nella propria API.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Screenshot
Cattura uno screenshot dello schermo che si trova dietro la finestra di powershell e lo invia insieme al prompt. 
Nota che il modello attuale deve supportare immagini (Vision Language Models).

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: ss
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Sei stato addestrato su dati fino a ottobre 2023._
<!--PowershaiAiDocBlockEnd-->
