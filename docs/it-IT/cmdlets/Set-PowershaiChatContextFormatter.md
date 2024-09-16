---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-PowershaiChatContextFormatter

## SYNOPSIS <!--!= @#Synop !-->
Definisce quale sarà la funzione usata per formattare gli oggetti passati al parametro Send-PowershaiChat -Context

## DESCRIPTION <!--!= @#Desc !-->
Quando si invoca Send-PowershaiChat in un pipe, o passando direttamente il parametro -Context, questo inietterà tale oggetto nel prompt del LLM.  
Prima di iniettare, deve convertire questo oggetto in una stringa.  
Questa conversione è chiamata "Context Formatter" qui nel Powershai.  
Il Context Formatter è una funzione che prenderà ogni oggetto passato e lo convertirà in una stringa per essere iniettata nel prompt.
La funzione utilizzata deve ricevere come primo parametro l'oggetto da convertire.  

Gli altri parametri sono a discrezione. I loro valori possono essere specificati usando il parametro -Params di questa funzione!

Il powershai mette a disposizione context formatter nativi.  
Utilizzare Get-Command ConvertTo-PowershaiContext* o Get-PowershaiContextFormatters per ottenere l'elenco!

Una volta che i context formatter nativi sono solo funzioni powershell, puoi utilizzare Get-Help Nome, per ottenere maggiori dettagli.

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
Nome della funzione powershell
Utilizzare il comando Get-PowershaiContextFormatters per vedere l'elenco

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
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
