---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Format-PowershaiContext

## SYNOPSIS <!--!= @#Synop !-->
Formatta un oggetto per essere iniettato nel contesto di un messaggio inviato in una chat Powershai

## DESCRIPTION <!--!= @#Desc !-->
Dato che gli LLM elaborano solo stringhe, gli oggetti passati nel contesto devono essere convertiti in un formato stringa, prima di essere iniettati nel prompt.
E, poiché esistono diverse rappresentazioni di un oggetto in stringa, Powershai consente all'utente di avere il pieno controllo su questo.

Ogni volta che un oggetto deve essere iniettato nel prompt, quando viene invocato con Send-PowershaAIChat, tramite pipeline o parametro Contesto, questo cmdlet verrà invocato.
Questo cmdlet è responsabile della trasformazione di questo oggetto in stringa, indipendentemente dall'oggetto, sia esso array, hashtable, personalizzato, ecc.

Lo fa invocando la funzione di formattazione configurata usando Set-PowershaiChatContextFormatter
In generale, non è necessario invocare questa funzione direttamente, ma potresti volerla invocare quando vuoi fare qualche test!

## SYNTAX <!--!= @#Syntax !-->

```
Format-PowershaiContext [[-obj] <Object>] [[-params] <Object>] [[-func] <Object>] [[-ChatId] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -obj
Oggetto qualsiasi da iniettare

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

### -params
Parametri da passare alla funzione di formattazione

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

### -func
Sovrascrivere la funzione da invocare. Se non specificato usa il predefinito del chat.

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

### -ChatId
Chat in cui operare

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: .
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
