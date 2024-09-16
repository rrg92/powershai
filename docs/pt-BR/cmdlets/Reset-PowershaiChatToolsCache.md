---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS <!--!= @#Synop !-->
Limpa o cache de AI Tools.

## DESCRIPTION <!--!= @#Desc !-->
O PowershAI mantém um cache com as tools "compiladas".
Quando o PowershAI envia a lista de tools pro LLM, ele precisa enviar junto a descrição da tools, lista de paraemtros, descrição, etc.  
Montar essa lista pode consumir um tempo signifciativo, uma vez que ele vai varrer a lista de tools, funcoes, e pra cada um, varrer o help (e o help de cada parametro).

Ao adicionar um cmdlet como Add-AiTool, ele não compila naquele momento.
Ele deixa para fazer isso quando ele precisa invocar o LLM, na funcao Send-PowershaiChat.  
Se o cache não existe, então ele compila ali na hora, o que pode fazer com que esse primeiro envio ao LLM, demora alguns millisegundos ou segundos a mais que o normal.  

Esse impacto é proprocional ao numero de funcoes e parâmetros enviados.  

Sempre que você usa o Add-AiTool ou Add-AiScriptTool, ele invalida o cache, fazendo com que na proxima execução, ele seja gerado.  
ISso permite adicionar muitas funcoes de uma só vez, sem que seja compilado cada vez que você adicona.

Porém, se você alterar sua função, o cache não é recalcuado.  
Então, você deve usar esse cmdlet para que a proxima execução contenha os dados atualizados das suas tools após alteracoes de código ou de script.

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