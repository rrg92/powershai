---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Add-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Aggiunge funzioni, script, eseguibili come strumento invocabile da LLM nella chat corrente (o predefinito per tutti).

## DESCRIPTION <!--!= @#Desc !-->
Aggiunge funzioni nella sessione corrente all'elenco di chiamate di strumenti consentite!
Quando viene aggiunto un comando, viene inviato al modello corrente come opzione per la chiamata di strumenti.
L'aiuto disponibile della funzione verrà utilizzato per descriverla, inclusi i parametri.
In questo modo, puoi, in fase di esecuzione, aggiungere nuove abilità all'IA che possono essere invocate da LLM ed eseguite da PowershAI.  

Quando aggiungi script, tutte le funzioni all'interno dello script vengono aggiunte in una sola volta.

Per ulteriori informazioni sugli strumenti, consulta l'argomento about_Powershai_Chats

MOLTO IMPORTANTE: 
NON AGGIUNGERE MAI COMANDI CHE NON CONOSCI O CHE POTREBBERO COMPROMETTERE IL TUO COMPUTER.  
POWERSHELL LO ESEGUIRÀ SU RICHIESTA DI LLM E CON I PARAMETRI CHE LLM INVOCA, E CON LE CREDENZIALI DELL'UTENTE ATTUALE.  
SE HAI EFFETTUATO L'ACCESSO CON UN ACCOUNT PRIVILEGIATO, COME L'AMMINISTRATORE, NOTA CHE POTRAI ESEGUIRE QUALSIASI AZIONE SU RICHIESTA DI UN SERVER REMOTO (LLM).

## SYNTAX <!--!= @#Syntax !-->

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -names
Nome del comando, percorso dello script o eseguibile
Può essere una matrice di stringhe con questi elementi misti.
Quando il nome termina con .ps1, viene trattato come uno script (cioè, verranno caricate le funzioni dello script)
Se desideri trattare con un comando (esegui lo script), fornisci il parametro -Command, per forzare il trattamento come comando!

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

### -description
Descrizione per questo strumento da passare a LLM.  
Il comando utilizzerà l'aiuto e invierà anche il contenuto descritto
Se questo parametro viene aggiunto, viene inviato insieme all'aiuto.

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

### -ForceCommand
Forza il trattamento come comando. Utile quando vuoi che uno script venga eseguito come comando.
ùtil solo quando passi un nome di file ambiguo, che coincide con il nome di un comando!

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
Chat in cui creare lo strumento

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

### -Global
Crea lo strumento a livello globale, ovvero sarà disponibile in tutte le chat

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
