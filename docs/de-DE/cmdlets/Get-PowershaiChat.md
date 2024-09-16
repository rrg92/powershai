---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Gibt einen oder mehrere Chats zurück, die mit New-PowershaAIChat erstellt wurden

## DESCRIPTION <!--!= @#Desc !-->
Dieser Befehl ermöglicht die Rückgabe des Objekts, das einen Powershai-Chat darstellt.  
Dieses Objekt ist das Objekt, auf das intern von den Befehlen verwiesen wird, die im Powershai-Chat arbeiten.  
Obwohl Sie bestimmte Parameter direkt ändern können, wird dies nicht empfohlen.  
Verwenden Sie die Ausgabe dieses Befehls immer als Eingabe für die anderen PowershaiChat-Befehle.

## SYNTAX <!--!= @#Syntax !-->

```
Get-PowershaiChat [[-ChatId] <Object>] [-SetActive] [-NoError] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
ID des Chats
Sondernamen:
	. - Bezeichnet den eigenen Chat 
 	* - Bezeichnet alle Chats

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

### -SetActive
Definiert den Chat als aktiv, wenn die angegebene ID kein Sondername ist.

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```

### -NoError
Ignoriert Validierungsfehler

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
