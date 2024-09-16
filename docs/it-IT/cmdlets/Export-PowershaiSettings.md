---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Export-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Esporta le impostazioni della sessione corrente in un file, crittografato da una password

## DESCRIPTION <!--!= @#Desc !-->
Questo cmdlet è utile per salvare le impostazioni, come i Token, in modo sicuro.  
Richiede una password e la usa per creare un hash e crittografare i dati di configurazione della sessione in AES256.  

Le impostazioni esportate sono tutte quelle definite nella variabile $POWERSHAI_SETTINGS.  
Questa variabile è una hashtable che contiene tutti i dati configurati dai provider, inclusi i token.  

Per impostazione predefinita, le chat non vengono esportate a causa della quantità di dati coinvolti, il che potrebbe rendere il file troppo grande!

Il file esportato viene salvato in una directory creata automaticamente, per impostazione predefinita, nella home dell'utente ($HOME).  
Gli oggetti vengono esportati tramite Serialization, che è lo stesso metodo utilizzato da Export-CliXml.  

I dati vengono esportati in un formato proprietario che può essere importato solo con Import-PowershaiSettings e fornendo la stessa password.  

Poiché PowershAI non esegue un'esportazione automatica, si consiglia di richiamare questo comando ogni volta che si verificano modifiche alla configurazione, come l'inclusione di nuovi token.  

La directory di esportazione può essere qualsiasi percorso valido, inclusi i drive cloud come OneDrive, Dropbox, ecc.  

Questo comando è stato creato con l'intento di essere interattivo, ovvero richiede l'input dell'utente dalla tastiera.

## SYNTAX <!--!= @#Syntax !-->

```
Export-PowershaiSettings [[-ExportDir] <Object>] [-Chats] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Esportazione delle impostazioni predefinite!
```powershell
Export-PowershaiSettings
```

### Esporta tutto, comprese le chat!
```powershell
Export-PowershaiSettings -Chat
```

### Esportazione su OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Export-PowershaiSettings
```

## PARAMETERS <!--!= @#Params !-->

### -ExportDir
Directory di esportazione
Per impostazione predefinita, è una directory denominata .powershai nel profilo dell'utente, ma è possibile specificare la variabile di ambiente POWERSHAI_EXPORT_DIR per modificarla.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: $Env:POWERSHAI_EXPORT_DIR
Accept pipeline input: false
Accept wildcard characters: false
```

### -Chats
Se specificato, include le chat nell'esportazione
Tutte le chat verranno esportate

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
