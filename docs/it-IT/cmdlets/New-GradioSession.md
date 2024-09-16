---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Crea una nuova sessione Gradio.

## DESCRIPTION <!--!= @#Desc !-->
Una sessione rappresenta una connessione a un'app Gradio.  
Pensa a una sessione come a una scheda del browser aperta e connessa a una determinata app Gradio.  
I file inviati, le chiamate effettuate, gli accessi, sono tutti registrati in questa sessione.

Questo cmdlet restituisce un oggetto che chiamiamo "GradioSession".  
Questo oggetto può essere utilizzato in altri cmdlet che dipendono dalla sessione (e può essere impostata una sessione attiva, che tutti i cmdlet utilizzano per impostazione predefinita se non specificato).  

Ogni sessione ha un nome che la identifica in modo univoco. Se non specificato dall'utente, verrà creato automaticamente in base all'URL dell'app.  
Non possono esistere 2 sessioni con lo stesso nome.

Quando si crea una sessione, questo cmdlet salva questa sessione in un repository interno di sessioni.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSession [[-AppUrl] <Object>] [[-Name] <Object>] [[-DownloadPath] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl
Url dell'app

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

### -Name
Nome univoco che identifica questa sessione!

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

### -DownloadPath
Directory in cui effettuare il download dei file

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Force
Force recreate

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
