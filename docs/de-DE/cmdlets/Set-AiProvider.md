---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiProvider

## SYNOPSIS <!--!= @#Synop !-->
Ändert den aktuellen Provider

## DESCRIPTION <!--!= @#Desc !-->
Provider sind Skripte, die den Zugriff auf ihre jeweiligen APIs implementieren.  
Jeder Provider hat seine eigene Art, APIs aufzurufen, das Format der Daten, das Schema der Antwort usw.  

Wenn Sie den Provider ändern, beeinflussen Sie bestimmte Befehle, die mit dem aktuellen Provider arbeiten, wie z. B. `Get-AiChat`, `Get-AiModels` oder die Chats, wie z. B. Send-PowershaAIChat.
Weitere Informationen zu den Providern finden Sie im Thema about_Powershai_Providers

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiProvider [[-provider] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -provider
Name des Providers

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


<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
