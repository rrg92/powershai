---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Add-PowershaiChatTool

## SYNOPSIS <!--!= @#Synop !-->
Agrega funciones, scripts, ejecutables como una herramienta invocable por el LLM en el chat actual (o por defecto para todos).

## DESCRIPTION <!--!= @#Desc !-->
Agrega funciones en la sesión actual a la lista de herramientas que se pueden llamar.
Cuando se agrega un comando, se envía al modelo actual como una opción para llamar a la herramienta.
La ayuda disponible de la función se usará para describirla, incluidos los parámetros.
Con esto, puedes, en tiempo de ejecución, agregar nuevas habilidades a la IA que se pueden invocar por el LLM y ejecutar por PowershAI.  

Al agregar scripts, todas las funciones dentro del script se agregan de una sola vez.

Para obtener más información sobre las herramientas, consulta el tema about_Powershai_Chats

MUY IMPORTANTE: 
NUNCA AGREGUES COMANDOS QUE NO CONOZCAS O QUE PUEDAN COMPROMETER TU COMPUTADORA.  
POWERSHELL LO EJECUTARÁ A PEDIDO DEL LLM Y CON LOS PARÁMETROS QUE EL LLM INVOQUE, Y CON LAS CREDENCIALES DEL USUARIO ACTUAL.  
SI ESTÁS INICIADO SESIÓN CON UNA CUENTA PRIVILEGIADA, COMO EL ADMINISTRADOR, TEN EN CUENTA QUE PUEDES EJECUTAR CUALQUIER ACCIÓN A PEDIDO DE UN SERVIDOR REMOTO (EL LLM).

## SYNTAX <!--!= @#Syntax !-->

```
Add-PowershaiChatTool [[-names] <Object>] [[-description] <Object>] [-ForceCommand] [[-ChatId] <Object>] [-Global] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -names
Nombre del comando, ruta del script o ejecutable
Puede ser una matriz de cadenas con estos elementos mezclados.
Cuando el nombre que termina con .ps1 se pasa, se trata como un script (es decir, se cargarán las funciones del script)
Si deseas tratar con un comando (ejecutar el script), informa el parámetro -Command, para forzar que se trate como un comando.

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

### -description
Descripción para esta herramienta que se pasará al LLM.  
El comando usará la ayuda y enviará también el contenido descrito.
Si se agrega este parámetro, se envía junto con la ayuda.

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -ForceCommand
Fuerza el tratamiento como comando. Útil cuando quieres que un script se ejecute como comando.
Útil solo cuando pasas un nombre de archivo ambiguo, que coincide con el nombre de algún comando.

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

### -ChatId
Chat en el que crear la herramienta

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```

### -Global
Crea la herramienta globalmente, es decir, estará disponible en todos los chats

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
_Traducido automáticamente usando PowershAI e IA. 
_
<!--PowershaiAiDocBlockEnd-->
