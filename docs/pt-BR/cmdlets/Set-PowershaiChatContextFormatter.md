---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS <!--!= @#Synop !-->
Define qual será a funcao usada para formatar os objetos passados pro parâmetro Send-PowershaiChat -Context

## DESCRIPTION <!--!= @#Desc !-->
Ao invocar Send-PowershaiChat em um pipe, ou passando diretamente o parâmetro -Context, ele irá injetar esse objeto no prompt do LLM.  
Antes de injetar, ele deve converter esse objeto para uma string.  
Essa conversão é chamada de "Context Formatter" aqui no Powershai.  
O Context Formatter é uma funcao que irá pegar cada objeto passado e convertê-lo para uma string para ser injetada no prompt.
A função usada deve receber como primeiro parametro o objeto a ser convertido.  

Os demais parametros ficam a criterio. Os valor deles pode ser especicicados usando o parametro -Params dessa funcao!

O powershai disponibiliza context formatters nativos.  
Utilize Get-Command ConvertTo-PowershaiContext* ou Get-PowershaiContextFormatters para obter a lista!

Uma vez que os context formatters nativos são apenas funções powershell, você pode usar o Get-Help Nome, para obter mais detalhes.

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
Nome da funcao powershell
Use o comando Get-PowershaiContextFormatters para ver a lista

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