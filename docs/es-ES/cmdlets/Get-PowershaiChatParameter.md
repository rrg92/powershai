---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChatParameter

## SYNOPSIS <!--!= @#Synop !-->
Devuelve la lista de parámetros disponibles en un chat

## DESCRIPTION <!--!= @#Desc !-->
Este comando devuelve un objeto que contiene la lista de propiedades.  
El objeto es, en realidad, un array, donde cada elemento representa una propiedad.  

Este array devuelto tiene algunas modificaciones para facilitar el acceso a los parámetros. 
Puede acceder a los parámetros usando el objeto devuelto directamente, sin necesidad de filtrar sobre la lista de parámetros.
Esto es útil cuando se desea acceder a un parámetro específico de la lista.

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
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
