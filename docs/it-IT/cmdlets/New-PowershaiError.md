---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiError

## SYNOPSIS <!--!= @#Synop !-->
Crea una nuova Exception personalizzata per PowershaAI

## DESCRIPTION <!--!= @#Desc !-->
Facilita la creazione di eccezioni personalizzate!
Viene utilizzata internamente dai provider per creare eccezioni con proprietà e tipi che possono essere recuperati in seguito.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiError [[-Message] <Object>] [[-Props] <Object>] [[-Type] <Object>] [[-Parent] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Message
Il messaggio dell'eccezione!

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

### -Props
Proprietà personalizzate

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @{}
Accept pipeline input: false
Accept wildcard characters: false
```

### -Type
Tipo aggiuntivo!

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

### -Parent
Eccezione padre!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
