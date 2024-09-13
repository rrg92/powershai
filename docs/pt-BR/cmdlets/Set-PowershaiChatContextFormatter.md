---
external help file: powershai-help.xml
Module Name: powershai
online version:
schema: 2.0.0
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS
Define qual será a funcao usada para formatar os objetos passados pro parâmetro Send-PowershaiChat -Context

## SYNTAX

```
Set-PowershaiChatContextFormatter [[-ChatId] <Object>] [[-Func] <Object>] [[-Params] <Object>]
```

## DESCRIPTION
Ao invocar Send-PowershaiChat em um pipe, ou passando diretamente o parâmetro -Context, ele irá injetar esse objeto no prompt do LLM.
 
Antes de injetar, ele deve converter esse objeto para uma string.
 
Essa conversão é chamada de "Context Formatter" aqui no Powershai.
 
O Context Formatter é uma funcao que irá pegar cada objeto passado e convertê-lo para uma string para ser injetada no prompt.
A função usada deve receber como primeiro parametro o objeto a ser convertido.
 

Os demais parametros ficam a criterio.
Os valor deles pode ser especicicados usando o parametro -Params dessa funcao!

O powershai disponibiliza context formatters nativos.
 
Utilize Get-Command ConvertTo-PowershaiContext* ou Get-PowershaiContextFormatters para obter a lista!

Uma vez que os context formatters nativos são apenas funções powershell, você pode usar o Get-Help Nome, para obter mais detalhes.

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

### -Func
Nome da funcao powershell
Use o comando Get-PowershaiContextFormatters para ver a lista

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Str
Accept pipeline input: False
Accept wildcard characters: False
```

### -Params
{{ Fill Params Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
