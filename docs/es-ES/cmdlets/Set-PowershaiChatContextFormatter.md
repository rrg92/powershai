---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS <!--!= @#Synop !-->
Define qué función se usará para formatear los objetos pasados al parámetro Send-PowershaiChat -Context

## DESCRIPTION <!--!= @#Desc !-->
Al invocar Send-PowershaiChat en un pipe, o pasando directamente el parámetro -Context, éste inyectará este objeto en el prompt del LLM.  
Antes de inyectarlo, debe convertir este objeto a una cadena.  
Esta conversión se llama "Context Formatter" aquí en Powershai.  
El Context Formatter es una función que tomará cada objeto pasado y lo convertirá a una cadena para ser inyectada en el prompt.
La función usada debe recibir como primer parámetro el objeto a convertir.  

Los demás parámetros quedan a criterio. ¡Los valores de los mismos pueden ser especificados usando el parámetro -Params de esta función!

Powershai pone a disposición formateadores de contexto nativos.  
¡Utiliza Get-Command ConvertTo-PowershaiContext* o Get-PowershaiContextFormatters para obtener la lista!

Una vez que los formateadores de contexto nativos son simplemente funciones de PowerShell, puedes usar el comando Get-Help Nombre, para obtener más detalles.

## SYNTAX <!--!= @#Syntax !-->

```
Set-PowershaiChatContextFormatter [[-ChatId] <Object>] [[-Func] <Object>] [[-Params] <Object>] [<CommonParameters>]
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

### -Func
Nombre de la función de PowerShell
Usa el comando Get-PowershaiContextFormatters para ver la lista

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: Str
Accept pipeline input: false
Accept wildcard characters: false
```

### -Params

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




<!--PowershaiAiDocBlockStart-->
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
