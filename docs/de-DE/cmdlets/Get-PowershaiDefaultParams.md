---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiDefaultParams

## SYNOPSIS <!--!= @#Synop !-->
Gibt eine Referenz auf die Variable zurück, die die Standardparameter definiert.

## DESCRIPTION <!--!= @#Desc !-->
In PowerShell haben Module ihren eigenen Variablenbereich.  
Wenn Sie versuchen, diese Variable außerhalb des richtigen Bereichs zu definieren, wirkt sich dies nicht auf die Befehle der Module aus.  
Dieser Befehl ermöglicht es dem Benutzer, auf die Variable zuzugreifen, die den Standardparameter der Befehle des Moduls steuert.  
Meistens wird dies zum Debuggen verwendet, aber manchmal möchte ein Benutzer möglicherweise Standardparameter definieren.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiDefaultParams [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
Das folgende Beispiel zeigt, wie die Standard-Debug-Variable des Befehls Invoke-Http definiert wird.
```


## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
