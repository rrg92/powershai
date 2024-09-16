---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Erstellt eine neue Gradio-Sitzung.

## DESCRIPTION <!--!= @#Desc !-->
Eine Sitzung repräsentiert eine Verbindung zu einer Gradio-App.  
Stell dir eine Sitzung wie eine Browser-Registerkarte vor, die mit einer bestimmten Gradio-App verbunden ist.  
Hochgeladene Dateien, Aufrufe, Anmeldungen werden alle in dieser Sitzung gespeichert.

Dieser Cmdlet gibt ein Objekt zurück, das wir "GradioSession" nennen.  
Dieses Objekt kann in anderen Cmdlets verwendet werden, die von einer Sitzung abhängig sind (und eine aktive Sitzung kann definiert werden, die standardmäßig von allen Cmdlets verwendet wird, wenn nicht anders angegeben).  

Jede Sitzung hat einen Namen, der sie eindeutig identifiziert. Wenn dieser nicht vom Benutzer angegeben wird, wird er automatisch anhand der URL der App erstellt.  
Es können keine 2 Sitzungen mit demselben Namen existieren.

Beim Erstellen einer Sitzung speichert dieses Cmdlet diese Sitzung in einem internen Sitzungsrepository.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSession [[-AppUrl] <Object>] [[-Name] <Object>] [[-DownloadPath] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl
Url der App

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
Einzigartiger Name, der diese Sitzung identifiziert!

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
Verzeichnis, in dem die Dateien heruntergeladen werden sollen

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
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
