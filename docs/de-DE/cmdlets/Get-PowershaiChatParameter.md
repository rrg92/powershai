---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
Gibt die Liste der verfügbaren Parameter in einem Chat zurück

## DESCRIPTION <!--!= @#Desc !-->
Dieser Befehl gibt ein Objekt zurück, das die Liste der Eigenschaften enthält.  
Das Objekt ist tatsächlich ein Array, wobei jedes Element eine Eigenschaft darstellt.  

Dieses zurückgegebene Array hat einige Modifikationen, um den Zugriff auf die Parameter zu erleichtern. 
Sie können auf die Parameter zugreifen, indem Sie das zurückgegebene Objekt direkt verwenden, ohne die Parameterliste filtern zu müssen.
Dies ist nützlich, wenn Sie auf einen bestimmten Parameter in der Liste zugreifen möchten.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChatParameter [[-ChatId] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
$MyParams = Get-PowershaiChatParameter
```


## PARAMETERS <!--!= @#Params !-->

### -ChatId

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
