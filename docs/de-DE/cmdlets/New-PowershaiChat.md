---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-PowershaiChat

## SYNOPSIS <!--!= @#Synop !-->
Erstellt einen neuen Powershai Chat.

## DESCRIPTION <!--!= @#Desc !-->
PowershaAI bringt ein Konzept von "Chats", ähnlich den Chats, die Sie bei OpenAI sehen, oder den "Threads" der API von Assistants.  
Jeder erstellte Chat hat seine eigenen Parameter, Kontext und Verlauf.  
Wenn Sie das Cmdlet Send-PowershaiChat (Alias ia) verwenden, senden Sie Nachrichten an das Modell, und der Verlauf dieser Unterhaltung mit dem Modell bleibt im Chat erhalten, der hier von PowershAI erstellt wurde.  
Das bedeutet, dass der gesamte Verlauf Ihrer Unterhaltung mit dem Modell in Ihrer PowershAI-Sitzung gespeichert wird und nicht im Modell oder in der API.  
So behält PowershAI die vollständige Kontrolle darüber, was an den LLM gesendet wird, und ist nicht auf Mechanismen verschiedener APIs von verschiedenen Anbietern angewiesen, um den Verlauf zu verwalten. 


Jeder Chat hat einen Satz von Parametern, die sich beim Ändern nur auf diesen Chat auswirken.  
Einige Parameter von PowershAI sind global, z. B. der verwendete Anbieter. Wenn Sie den Anbieter ändern, verwendet der Chat den neuen Anbieter, behält aber denselben Verlauf bei.  
Dies ermöglicht es Ihnen, mit verschiedenen Modellen zu kommunizieren, während Sie denselben Verlauf beibehalten.  

Neben diesen Parametern hat jeder Chat einen Verlauf.  
Der Verlauf enthält alle Gespräche und Interaktionen, die mit den Modellen geführt wurden, und speichert die von den APIs zurückgegebenen Antworten.

Ein Chat hat auch einen Kontext, der nichts anderes ist als alle gesendeten Nachrichten.  
Jedes Mal, wenn eine neue Nachricht in einem Chat gesendet wird, fügt Powershai diese Nachricht zum Kontext hinzu.  
Wenn die Antwort des Modells empfangen wird, wird diese Antwort zum Kontext hinzugefügt.  
Bei der nächsten gesendeten Nachricht wird der gesamte Nachrichtenverlauf des Kontexts gesendet, so dass das Modell, unabhängig vom Anbieter, das Gedächtnis des Gesprächs hat.  

Da der Kontext in Ihrer Powershell-Sitzung gespeichert wird, sind Funktionen wie das Speichern Ihres Verlaufs auf dem Datenträger, die Implementierung eines exklusiven Anbieters, um Ihren Verlauf in der Cloud zu speichern, die Speicherung nur auf Ihrem PC usw. möglich. Zukünftige Funktionen können davon profitieren.

Alle *-PowershaiChat-Befehle drehen sich um den aktiven Chat oder den Chat, den Sie explizit im Parameter (in der Regel mit dem Namen -ChatId) angeben.  
Der aktive Chat ist der Chat, an den Nachrichten gesendet werden, wenn kein ChatId angegeben wird (oder wenn der Befehl es nicht erlaubt, einen expliziten Chat anzugeben).  

Es gibt einen speziellen Chat namens "default", der immer dann erstellt wird, wenn Sie Send-PowershaiChat verwenden, ohne einen Chat anzugeben, und wenn kein aktiver Chat definiert ist.  

Wenn Sie Ihre Powershell-Sitzung schließen, geht dieser gesamte Chat-Verlauf verloren.  
Sie können ihn mithilfe des Befehls Export-PowershaiSettings auf dem Datenträger speichern. Der Inhalt wird verschlüsselt mit einem Passwort gespeichert, das Sie angeben.

Beim Senden von Nachrichten verwendet PowershAI einen internen Mechanismus, der den Kontext des Chats bereinigt, um zu vermeiden, dass mehr als nötig gesendet wird.
Die Größe des lokalen Kontexts (hier in Ihrer Powershai-Sitzung und nicht im LLM) wird durch einen Parameter gesteuert (verwenden Sie Get-PowershaiChatParameter, um die Liste der Parameter anzuzeigen).

Beachten Sie, dass Powershell abhängig von der Menge der gesendeten und zurückgegebenen Informationen sowie den Konfigurationsparametern möglicherweise viel Speicherplatz beansprucht. Sie können den Kontext und den Verlauf Ihres Chats manuell mithilfe von Reset-PowershaiCurrentChat bereinigen.

Weitere Informationen finden Sie im Thema about_Powershai_Chats.

## SYNTAX <!--!= @#Syntax !-->

```
New-PowershaiChat [[-ChatId] <Object>] [-IfNotExists] [-Recreate] [[-Tools] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -ChatId
ID des Chats. Wenn nicht angegeben, wird eine Standard-ID generiert.
Einige Standard-IDs sind für den internen Gebrauch reserviert. Wenn Sie sie verwenden, kann dies zu Instabilitäten in PowershAI führen.
Die folgenden Werte sind reserviert:
 default 
 _pwshai_*

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

### -IfNotExists
Erstellt nur, wenn noch kein Chat mit demselben Namen existiert.

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

### -Recreate
Chat neu erstellen, auch wenn er bereits existiert!

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

### -Tools
Chat erstellen und diese Tools einfügen!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: @()
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
