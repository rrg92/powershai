---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Import-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Importa una configurazione esportata con Export-PowershaiSettings

## DESCRIPTION <!--!= @#Desc !-->
Questo cmdlet è il pair di Export-PowershaiSettings, e come il nome indica, importa i dati che sono stati esportati.  
Dovresti assicurarti che la stessa password e lo stesso file siano passati.  

IMPORTANTE: Questo comando sovrascriverà tutti i dati configurati nella sessione. Eseguilo solo se sei assolutamente sicuro che nessun dato configurato in precedenza possa essere perso.
Ad esempio, un nuovo token API generato di recente.

Se hai specificato un percorso di esportazione diverso da quello predefinito, usando la variabile POWERSHAI_EXPORT_DIR, dovresti usare lo stesso qui.

Il processo di importazione convalida alcuni header per assicurarsi che i dati siano stati decrittati correttamente.  
Se la password fornita è errata, gli hash non saranno uguali e verrà generato l'errore di password errata.

Se, d'altra parte, viene visualizzato un errore di formato file non valido, significa che si è verificata una corruzione nel processo di importazione o che c'è un bug in questo comando.  
In questo caso, puoi aprire un'issue su github segnalando il problema.

## SYNTAX <!--!= @#Syntax !-->

```
Import-PowershaiSettings [[-ExportDir] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Importazione predefinita
```powershell
Import-PowershaiSettings
```

### Importazione da OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Import-PowershaiSettings
```
Importa le impostazioni che sono state esportate in una directory alternativa (OneDrive).

## PARAMETERS <!--!= @#Params !-->

### -ExportDir

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



<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
