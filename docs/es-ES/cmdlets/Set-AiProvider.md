---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
Cambia el proveedor actual

## DESCRIPTION <!--!= @#Desc !-->
Los proveedores son scripts que implementan el acceso a sus respectivas APIs.  
Cada proveedor tiene su forma de invocar APIs, formato de los datos, schema de la respuesta, etc.  

Al cambiar el proveedor, afecta ciertos comandos que operan en el proveedor actual, como `Get-AiChat`, `Get-AiModels`, o los Chats, como Send-PowershaAIChat.
Para más detalles sobre los proveedores consulte el tema about_Powershai_Providers

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -provider
nombre del proveedor

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


<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
