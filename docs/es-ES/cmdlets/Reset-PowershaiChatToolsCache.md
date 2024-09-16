---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS <!--!= @#Synop !-->
Limpia o cache de herramientas de IA.

## DESCRIPTION <!--!= @#Desc !-->
PowershAI mantiene un caché con las herramientas "compiladas".
Cuando PowershAI envía la lista de herramientas al LLM, necesita enviar junto la descripción de las herramientas, lista de parámetros, descripción, etc.  
Montar esta lista puede consumir un tiempo significativo, ya que recorrerá la lista de herramientas, funciones, y para cada uno, recorrerá la ayuda (y la ayuda de cada parámetro).

Al agregar un cmdlet como Add-AiTool, no compila en ese momento.
Deja hacerlo cuando necesita invocar el LLM, en la función Send-PowershaiChat.  
Si el caché no existe, entonces compila allí en ese momento, lo que puede hacer que este primer envío al LLM, demore algunos milisegundos o segundos más de lo normal.  

Este impacto es proporcional al número de funciones y parámetros enviados.  

Siempre que use Add-AiTool o Add-AiScriptTool, invalida el caché, haciendo que en la próxima ejecución, se genere.  
Esto permite agregar muchas funciones de una sola vez, sin que se compile cada vez que agrega.

Sin embargo, si modifica su función, el caché no se recalcula.  
Entonces, debe usar este cmdlet para que la próxima ejecución contenga los datos actualizados de sus herramientas después de las modificaciones de código o de secuencia de comandos.

## SYNTAX <!--!= @#Syntax !-->

```
Reset-PowershaiChatToolsCache [[-ChatId] <Object>] [<CommonParameters>]
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
