---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Reset-PowershaiChatToolsCache

## SYNOPSIS
Limpa o cache de AI Tools.

## SYNTAX

```
Reset-PowershaiChatToolsCache [[-ChatId] <Object>] [<CommonParameters>]
```

## DESCRIPTION
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

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ChatId
{{ Fill ChatId Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
