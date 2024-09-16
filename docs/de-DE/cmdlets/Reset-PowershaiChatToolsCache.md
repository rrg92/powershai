---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS <!--!= @#Synop !-->
Limpa o cache das ferramentas de IA.

## DESCRIPTION <!--!= @#Desc !-->
O PowershAI mantém um cache com as ferramentas "compiladas".
Quando o PowershAI envia a lista de ferramentas para o LLM, ele precisa enviar junto a descrição das ferramentas, lista de parâmetros, descrição, etc.  
Montar essa lista pode consumir um tempo significativo, uma vez que ele vai varrer a lista de ferramentas, funções, e para cada um, varrer o help (e o help de cada parâmetro).

Ao adicionar um cmdlet como Add-AiTool, ele não compila naquele momento.
Ele deixa para fazer isso quando ele precisa invocar o LLM, na função Send-PowershaiChat.  
Se o cache não existe, então ele compila ali na hora, o que pode fazer com que esse primeiro envio ao LLM, demora alguns milissegundos ou segundos a mais que o normal.  

Esse impacto é proporcional ao número de funções e parâmetros enviados.  

Sempre que você usa o Add-AiTool ou Add-AiScriptTool, ele invalida o cache, fazendo com que na próxima execução, ele seja gerado.  
ISso permite adicionar muitas funções de uma só vez, sem que seja compilado cada vez que você adiciona.

Porém, se você alterar sua função, o cache não é recalculado.  
Então, você deve usar esse cmdlet para que a próxima execução contenha os dados atualizados das suas ferramentas após alterações de código ou de script.

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
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
