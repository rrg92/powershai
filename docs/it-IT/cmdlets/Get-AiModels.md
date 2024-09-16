---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModels

## SYNOPSIS <!--!= @#Synop !-->
Elenca i modelli disponibili nel provider attuale

## DESCRIPTION <!--!= @#Desc !-->
Questo comando elenca tutti gli LLM che possono essere utilizzati con il provider attuale per l'uso in PowershaiChat.  
Questa funzione dipende dal fatto che il provider implementi la funzione GetModels.

L'oggetto restituito varia a seconda del provider, ma ogni provider deve restituire un array di oggetti, ognuno dei quali deve contenere, almeno, la proprietà id, che deve essere una stringa utilizzata per identificare il modello in altri comandi che dipendono da un modello.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModels [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
