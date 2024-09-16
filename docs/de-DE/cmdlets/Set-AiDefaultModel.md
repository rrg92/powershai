---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultModel

## SYNOPSIS <!--!= @#Synop !-->
Setzen Sie das standardmäßige LLM des aktuellen Anbieters

## DESCRIPTION <!--!= @#Desc !-->
Benutzer können das standardmäßige LLM konfigurieren, das verwendet wird, wenn ein LLM erforderlich ist.  
Befehle wie Send-PowershaAIChat, Get-AiChat erwarten ein Modell, und wenn es nicht angegeben ist, verwendet es das, was mit diesem Befehl festgelegt wurde.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultModel [[-model] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -model
Modell-ID, wie von Get-AiModels zurückgegeben.
Sie können die Tab-Taste verwenden, um die Befehlszeile zu vervollständigen.

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

### -Force
Erzwingen Sie die Definition des Modells, auch wenn es nicht von Get-AiModels zurückgegeben wird.

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
