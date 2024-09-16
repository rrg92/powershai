---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Remove-GradioSessionApi

## SYNOPSIS <!--!= @#Synop !-->
Entfernt API-Aufrufe aus der internen Liste der Sitzung

## DESCRIPTION <!--!= @#Desc !-->
Dieses Cmdlet hilft beim Entfernen von Evenots, die von Invoke-GradioSessionApi aus der internen Liste der Aufrufe generiert wurden. 
Normalerweise möchten Sie die Ereignisse entfernen, die Sie bereits verarbeitet haben, indem Sie die direkte ID übergeben.  
Dieses Cmdlet ermöglicht jedoch verschiedene Arten der Entfernung, einschließlich nicht verarbeiteter Ereignisse.  
Vorsicht ist geboten, da nach dem Entfernen eines Evenots aus der Liste auch die damit verbundenen Daten entfernt werden.  
Sofern Sie keine Kopie des Evenots (oder der resultierenden Daten) in einer anderen Variablen erstellt haben, können Sie diese Informationen nicht mehr abrufen.  

Das Entfernen von Evenots ist auch hilfreich, um den verbrauchten Arbeitsspeicher freizugeben, der je nach Anzahl der Ereignisse und Daten hoch sein kann.

## SYNTAX <!--!= @#Syntax !-->

```
Remove-GradioSessionApi [[-Target] <Object>] [-Force] [-Elegible] [[-session] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Target
Gibt das zu entfernende Ereignis oder die zu entfernenden Ereignisse an
Die ID kann auch einer dieser Sonderwerte entsprechen:
	clean 	- Entfernt nur die Aufrufe, die bereits abgeschlossen sind!
  all 	- Entfernt alles, einschließlich nicht abgeschlossener Aufrufe!

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
Standardmäßig werden nur Ereignisse mit dem Status "completed" entfernt!
Verwenden Sie -Force, um unabhängig vom Status zu entfernen!

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
Führt keine Entfernung durch, sondern gibt die Kandidaten zurück!

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
ID der Sitzung

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
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
