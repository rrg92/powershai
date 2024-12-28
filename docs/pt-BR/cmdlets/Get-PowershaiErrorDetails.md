---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiErrorDetails

## SYNOPSIS <!--!= @#Synop !-->
ObtÃ©m mais detalhes sobre exceptions e ErrorRecords disparaods pelo Powershai!

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiErrorDetails [[-ErrorObject] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ErrorObject
O erro a ser analisado. Se null, utiliza o ultimo error!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: $error[0]
Accept pipeline input: false
Accept wildcard characters: false
```