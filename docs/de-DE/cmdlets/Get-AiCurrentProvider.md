---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiCurrentProvider

## SYNOPSIS <!--!= @#Synop !-->
Ruft den aktiven Provider ab.

## DESCRIPTION <!--!= @#Desc !-->
Gibt das Objekt zurück, das den aktiven Provider repräsentiert.  
Provider werden als Objekte implementiert und in der Sitzungsspeicher, in einer globalen Variable, gespeichert.  
Diese Funktion gibt den aktiven Provider zurück, der mit dem Befehl Set-AiProvider definiert wurde.

Das zurückgegebene Objekt ist eine Hashtabelle, die alle Felder des Providers enthält.  
Dieser Befehl wird häufig von Providern verwendet, um den Namen des aktiven Providers abzurufen.  

Der Parameter -ContextProvider gibt den aktuellen Provider zurück, in dem das Skript ausgeführt wird.  
Wenn es in einem Skript eines Providers ausgeführt wird, gibt er diesen Provider zurück, anstatt den mit Set-AiProvider definierten Provider.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiCurrentProvider [-ContextProvider] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ContextProvider
Wenn aktiviert, verwendet es den Kontextprovider, d. h. wenn der Code in einer Datei im Verzeichnis eines Providers ausgeführt wird, wird dieser Provider angenommen.
Andernfalls wird der derzeit aktivierte Provider abgerufen.

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
