# Chats 


# Einführung <!--! @#Short --> 

PowershAI definiert den Begriff von Chats, die dabei helfen, den Verlauf und Kontext von Konversationen zu erstellen!  

# Details  <!--! @#Long --> 

PowershAI erstellt den Begriff von Chats, die dem Konzept von Chats in den meisten LLM-Diensten sehr ähnlich sind.  

Chats ermöglichen es, mit LLM-Diensten auf eine standardisierte Weise zu kommunizieren, unabhängig vom aktuellen Anbieter.  
Sie bieten eine Standardmethode für diese Funktionen:

- Chat-Verlauf 
- Kontext 
- Pipeline (Ergebnisse anderer Befehle verwenden)
- Tool-Aufruf (Befehle auf Anfrage des LLM ausführen)

Nicht alle Anbieter implementieren die Unterstützung von Chats.  
Um herauszufinden, ob ein Anbieter Chat-Unterstützung bietet, verwenden Sie das Cmdlet Get-AiProviders und überprüfen Sie die Eigenschaft "Chat". Wenn sie $true ist, wird Chat unterstützt.  
Sobald Chat unterstützt wird, werden möglicherweise nicht alle Funktionen unterstützt, aufgrund von Einschränkungen des Anbieters.  

## Einen neuen Chat starten 

Die einfachste Möglichkeit, einen neuen Chat zu starten, ist die Verwendung des Befehls Send-PowershaiChat.  
Natürlich müssen Sie ihn verwenden, nachdem Sie den Anbieter (mit `Set-AiProvider`) und die anfänglichen Einstellungen wie die Authentifizierung konfiguriert haben, falls erforderlich.  

```powershell 
Send-PowershaiChat "Hallo, ich spreche mit Ihnen aus Powershai"
```

Der Befehl `Send-PowershaiChat` hat aus Gründen der Einfachheit einen Alias namens `ia` (Abkürzung von "Intelligente Assistentin").  
Dadurch wird der Code viel kürzer und konzentrierter auf den Prompt:

```powershell 
ia "Hallo, ich spreche mit Ihnen aus Powershai"
```

Jede Nachricht wird in einem Chat gesendet.  Wenn Sie keinen Chat explizit erstellen, wird der spezielle Chat namens `default` verwendet.  
Sie können einen neuen Chat mit `New-PowershaiChat` erstellen.  

Jeder Chat hat seinen eigenen Konversationsverlauf und seine eigenen Einstellungen. Er kann eigene Funktionen usw. enthalten.
Das Erstellen zusätzlicher Chats kann hilfreich sein, wenn Sie mehrere Themen gleichzeitig bearbeiten möchten, ohne dass sie sich vermischen!


## Chat-Befehle  

Befehle, die Chats auf irgendeine Weise manipulieren, haben das Format `*-Powershai*Chat*`.  
In der Regel akzeptieren diese Befehle einen Parameter -ChatId, mit dem Sie den Namen oder das Objekt des mit `New-PowershaiChat` erstellten Chats angeben können.  
Wenn er nicht angegeben ist, verwenden sie den aktiven Chat.  

## Aktiver Chat  

Der aktive Chat ist der Standard-Chat, der von PowershaiChat-Befehlen verwendet wird.  
Wenn nur ein Chat erstellt wurde, gilt er als aktiver Chat.  
Wenn Sie mehr als einen aktiven Chat haben, können Sie mit dem Befehl `Set-PowershaiActiveChat` festlegen, welcher Chat aktiv sein soll. Sie können den Namen oder das Objekt übergeben, das von `New-PowershaiChat` zurückgegeben wird.


## Chat-Parameter  

Jeder Chat hat einige Parameter, die verschiedene Aspekte steuern.  
Beispielsweise die maximale Anzahl von Tokens, die vom LLM zurückgegeben werden sollen.  

Neue Parameter können in jeder Version von PowershAI hinzugefügt werden.  
Der einfachste Weg, die Parameter und ihre Funktion zu ermitteln, ist die Verwendung des Befehls `Get-PowershaiChatParameter`;  
Dieser Befehl zeigt die Liste der konfigurierbaren Parameter zusammen mit dem aktuellen Wert und einer Beschreibung ihrer Verwendung.  
Sie können die Parameter mit dem Befehl `Set-PowershaiChatParameter` ändern.  

Einige der aufgeführten Parameter sind direkte Parameter der API des Anbieters. Sie werden mit einer Beschreibung versehen, die darauf hinweist.  

## Kontext und Verlauf  

Jeder Chat hat einen Kontext und einen Verlauf.  
Der Verlauf ist der gesamte Verlauf der gesendeten und empfangenen Nachrichten in der Konversation.
Die Kontextgröße bestimmt, wie viel des Verlaufs an den LLM gesendet wird, damit er sich an die Antworten erinnert.  

Beachten Sie, dass diese Kontextgröße ein Konzept von PowershAI ist und nicht mit der "Context length" übereinstimmt, die in LLMs definiert ist.  
Die Kontextgröße wirkt sich nur auf Powershai aus. Je nach Wert kann sie die Context Length des Anbieters überschreiten, was zu Fehlern führen kann.  
Es ist wichtig, die Kontextgröße in einem Gleichgewicht zu halten, um den LLM über das Gesagte auf dem Laufenden zu halten, ohne die maximale Anzahl von Tokens des LLM zu überschreiten.  

Sie können die Kontextgröße über den Chat-Parameter steuern, d. h. mit `Set-PowershaiChatParameter`.

Beachten Sie, dass Verlauf und Kontext im Arbeitsspeicher der Sitzung gespeichert werden, d. h. wenn Sie Ihre Powershell-Sitzung schließen, gehen sie verloren.  
Zukünftig könnten wir Mechanismen implementieren, die es dem Benutzer ermöglichen, den Chat automatisch zu speichern und zwischen Sitzungen wiederherzustellen.  

Außerdem ist es wichtig zu bedenken, dass sehr lange Konversationen zu Überläufen oder einem hohen Arbeitsspeicherverbrauch von Powershell führen können, da der Verlauf im Arbeitsspeicher von Powershell gespeichert wird.  
Sie können die Chats jederzeit mit dem Befehl `Reset-PowershaiCurrentChat` zurücksetzen. Dadurch wird der gesamte Verlauf des aktiven Chats gelöscht.  
Seien Sie vorsichtig, da dadurch der gesamte Verlauf verloren geht und sich der LLM nicht an die im Verlauf der Konversation gemachten Angaben erinnert.  


## Pipeline  

Eine der mächtigsten Funktionen der Powershai-Chats ist die Integration in die Powershell-Pipeline.  
Im Grunde genommen können Sie das Ergebnis eines beliebigen Powershell-Befehls einfügen, und es wird als Kontext verwendet.  

PowershAI konvertiert die Objekte in Text und sendet sie in den Prompt.  
Anschließend wird die Chat-Nachricht hinzugefügt.  

Beispiel:

```
Get-Service | ia "Machen Sie eine Zusammenfassung darüber, welche Dienste im Windows-Betriebssystem nicht üblich sind"
```

In den Standardeinstellungen von Powershai wird der Befehl `ia` (Alias für `Send-PowershaiChat`) alle Objekte abrufen, die von `Get-Service` zurückgegeben werden, und sie in eine einzige, riesige Zeichenkette formatieren.  
Diese Zeichenkette wird dann in den Prompt des LLM eingefügt, und dem LLM wird mitgeteilt, dass er dieses Ergebnis als "Kontext" für den Prompt des Benutzers verwenden soll.  

Der Prompt des Benutzers wird anschließend angehängt.  

Dadurch wird ein mächtiger Effekt erzielt: Sie können die Ausgaben von Befehlen einfach mit Ihren Prompts integrieren, indem Sie ein einfaches Pipe-Symbol verwenden, was eine gängige Operation in Powershell ist.  
Der LLM berücksichtigt dies in der Regel gut.  

Obwohl es einen Standardwert gibt, haben Sie die volle Kontrolle darüber, wie diese Objekte gesendet werden.  
Die erste Möglichkeit, dies zu steuern, ist die Art und Weise, wie das Objekt in Text umgewandelt wird. Da der Prompt eine Zeichenkette ist, muss dieses Objekt in Text umgewandelt werden.  
Standardmäßig wird eine Standarddarstellung von Powershell gemäß dem Typ konvertiert (mithilfe des Befehls `Out-String`).  
Sie können dies mit dem Befehl `Set-PowershaiChatContextFormatter` ändern. Sie können beispielsweise JSON, eine Tabelle oder sogar ein benutzerdefiniertes Skript festlegen, um die volle Kontrolle zu haben.  

Eine weitere Möglichkeit, die Art und Weise zu steuern, wie der Kontext gesendet wird, ist die Verwendung des Chat-Parameters `ContextFormat`.  
Dieser Parameter steuert die gesamte Nachricht, die in den Prompt eingefügt wird. Es handelt sich um einen Scriptblock.  
Sie müssen ein String-Array zurückgeben, das dem gesendeten Prompt entspricht.  
Dieses Skript hat Zugriff auf Parameter wie das formatierte Objekt, das in der Pipeline übergeben wird, die Werte der Parameter des Befehls Send-PowershaiChat usw.  
Der Standardwert des Skripts ist hartcodiert, und Sie sollten ihn direkt im Code überprüfen, um zu erfahren, wie er gesendet wird (und um ein Beispiel für die Implementierung Ihres eigenen Skripts zu erhalten).  


###  Tools

Eine der großen Funktionen, die implementiert wurden, ist die Unterstützung von Function Calling (oder Tool Calling).  
Diese Funktion, die in mehreren LLMs verfügbar ist, ermöglicht es der KI, Funktionen aufzurufen, um zusätzliche Daten zur Antwort hinzuzufügen.  
Im Grunde genommen beschreiben Sie eine oder mehrere Funktionen und ihre Parameter, und das Modell kann entscheiden, ob es sie aufrufen soll.  

**WICHTIG: Sie können diese Funktion nur bei Anbietern verwenden, die Function Calling mit der gleichen Spezifikation wie OpenAI anbieten**

Weitere Informationen finden Sie in der offiziellen Dokumentation von OpenAI zu Function Calling: [Function Calling](https://platform.openai.com/docs/guides/function-calling).

Das Modell entscheidet nur, welche Funktionen aufgerufen werden, wann sie aufgerufen werden und welche Parameter verwendet werden sollen. Die Ausführung dieses Aufrufs erfolgt durch den Client, in unserem Fall PowershAI.  
Die Modelle erwarten die Definition der Funktionen, wobei beschrieben wird, was sie tun, ihre Parameter, Rückgabewerte usw.  
Ursprünglich erfolgt dies mit etwas wie OpenAPI Spec, um die Funktionen zu beschreiben.  
Powershell verfügt jedoch über ein leistungsstarkes Hilfesystem, das mithilfe von Kommentaren die Beschreibung von Funktionen und deren Parametern sowie die Datentypen ermöglicht.  

PowershAI integriert dieses Hilfesystem, indem es es in eine OpenAPI-Spezifikation übersetzt. Der Benutzer kann seine Funktionen normal schreiben und sie mit Kommentaren dokumentieren, und diese werden an das Modell gesendet.  

Um diese Funktion zu demonstrieren, wollen wir ein einfaches Tutorial durchführen: Erstellen Sie eine Datei namens `MinhasFuncoes.ps1` mit folgendem Inhalt:

```powershell
# Datei MinhasFuncoes.ps1, speichern Sie sie in einem beliebigen Verzeichnis!

<#
    .DESCRIPTION
    Listet die aktuelle Uhrzeit auf.
#>
function HoraAtual {
    return Get-Date
}

<#
    .DESCRIPTION
    Ruft eine zufällige Zahl ab!
#>
function NumeroAleatorio {
    param(
        # Minimale Zahl
        $Min = $null,
        
        # Maximale Zahl
        $Max = $null
    )
    return Get-Random -Min $Min -Max $Max
}
```
**Beachten Sie die Verwendung von Kommentaren zum Beschreiben von Funktionen und Parametern**.  
Dies ist eine Syntax, die von PowerShell unterstützt wird und als [Comment Based Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4) bekannt ist.

Fügen wir diese Datei nun zu PowershAI hinzu:

```powershell
import-module powershai 

Set-AiProvider openai 
Set-OpenaiToken #konfigurieren Sie den Token, wenn Sie ihn noch nicht konfiguriert haben.


# Fügen Sie das Skript als Tool hinzu!
# Angenommen, das Skript wurde unter C:\tempo\MinhasFuncoes.ps1 gespeichert.
Add-AiTool C:\tempo\MinhasFuncoes.ps1

# Überprüfen Sie, ob die Tools hinzugefügt wurden
Get-AiTool
```

Versuchen Sie, das Modell zu fragen, wie spät es ist, oder bitten Sie es, eine zufällige Zahl zu generieren! Sie werden feststellen, dass es Ihre Funktionen ausführt! Dies eröffnet endlose Möglichkeiten, und Ihrer Kreativität sind keine Grenzen gesetzt!

```powershell
ia "Wie viele Stunden?"
```

Im obigen Befehl wird das Modell die Funktion aufrufen. Auf dem Bildschirm sehen Sie, wie die Funktion aufgerufen wird!  
Sie können jeden beliebigen Powershell-Befehl oder jedes Skript als Tool hinzufügen.  
Verwenden Sie den Befehl `Get-Help -Full Add-AiTol`, um weitere Informationen zur Verwendung dieser leistungsstarken Funktionalität zu erhalten.

PowershAI kümmert sich automatisch darum, die Befehle auszuführen und die Antwort an das Modell zurückzusenden.  
Wenn das Modell entscheidet, mehrere Funktionen parallel auszuführen, oder darauf besteht, neue Funktionen auszuführen, verwaltet PowershAI dies automatisch.  
Beachten Sie, dass PowershAI aus Sicherheitsgründen eine Obergrenze für die maximale Anzahl von Ausführungen erzwingt, um eine Endlosschleife zu verhindern.  
Der Parameter, der diese Interaktionen mit dem Modell steuert, ist `MaxInteractions`.  


### Invoke-AiChatTools und Get-AiChat 

Diese beiden Cmdlets sind die Grundlage für die Chat-Funktion von Powershai.  
`Get-AiChat` ist der Befehl, mit dem Sie auf möglichst primitive Weise, fast so wie bei einem HTTP-Aufruf, mit dem LLM kommunizieren können.  
Im Grunde genommen ist es ein standardisierter Wrapper für die API, der es ermöglicht, Text zu generieren.  
Sie geben die Parameter an, die standardisiert sind, und er gibt eine Antwort zurück, die ebenfalls standardisiert ist,
unabhängig vom Anbieter muss die Antwort den gleichen Regeln folgen!

Das Cmdlet `Invoke-AiChatTools` ist etwas ausgefeilter und auf einer etwas höheren Ebene angesiedelt.  
Es ermöglicht Ihnen, Powershell-Funktionen als Tools anzugeben. Diese Funktionen werden in ein Format konvertiert, das das LLM versteht.  
Es verwendet das Hilfesystem von Powershell, um alle möglichen Metadaten abzurufen, die an das Modell gesendet werden sollen.  
Es sendet die Daten mit dem Befehl `Get-Aichat` an das Modell. Wenn es die Antwort erhält, prüft es, ob ein Tool Calling stattgefunden hat, und falls ja, führt es die entsprechenden Funktionen aus und gibt die Antwort zurück.  
Dieser Zyklus wird wiederholt, bis das Modell die Antwort beendet oder die maximale Anzahl von Interaktionen erreicht ist.  
Eine Interaktion ist ein API-Aufruf an das Modell. Wenn `Invoke-AiChatTools` mit Funktionen aufgerufen wird, kann es mehrere Aufrufe erfordern, um die Antworten an das Modell zurückzugeben.  

Das folgende Diagramm erklärt diesen Ablauf:

```
	sequenceDiagram
		Invoke-AiChatTools->>modell:prompt (INTERAKTION 1)
		modell->>Invoke-AiChatTools:(response, 3 function call)
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 1
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 2
		Invoke-AiChatTools-->Invoke-AiChatTools:Call Tool 3
		Invoke-AiChatTools->>modell:Ergebnis des Tool-Aufrufs + vorherige Prompts prompt (INTERAKTION 2)
		modell->>Invoke-AiChatTools:endgültige Antwort
```


#### Wie Befehle umgewandelt und aufgerufen werden

Der Befehl `Invoke-AiChatTools` erwartet im Parameter -Functions eine Liste von Powershell-Befehlen, die auf OpenAPI-Schemas abgebildet sind.  
Er erwartet ein Objekt, das wir OpenaiTool nennen, das die folgenden Eigenschaften enthält: (der Name OpenAiTool ergibt sich aus der Tatsache, dass wir das gleiche Tool-Calling-Format wie OpenAI verwenden)

- tools  
Diese Eigenschaft enthält das Schema des Function Calling, das an den LLM gesendet wird (in den Parametern, die diese Informationen erwarten).  

- map  
Dies ist eine Methode, die den auszuführenden Powershell-Befehl (Funktion, Alias, Cmdlet, ausführbare Datei usw.) zurückgibt.  
Diese Methode muss ein Objekt mit der Eigenschaft "func" zurückgeben, die der Name einer Funktion, eines ausführbaren Befehls oder eines Scriptblocks sein muss.  
Sie erhält im ersten Argument den Namen des Tools und im zweiten Argument das OpenAiTool-Objekt selbst (wie "this").

Neben diesen Eigenschaften können dem OpenaiTool-Objekt beliebige weitere Eigenschaften hinzugefügt werden. Dadurch kann das Skript-Mapping auf alle externen Daten zugreifen, die benötigt werden.  

Wenn das LLM den Request für das Function Calling zurückgibt, wird der Name der aufzurufenden Funktion an die Methode `map` übergeben, und diese muss zurückgeben, welcher Befehl ausgeführt werden soll.
Dies eröffnet vielfältige Möglichkeiten, da es zur Laufzeit möglich ist, den auszuführenden Befehl anhand eines Namens zu bestimmen.  
Dank dieses Mechanismus hat der Benutzer die volle Kontrolle und Flexibilität darüber, wie er auf das Tool Calling des LLM reagiert.  

Anschließend wird der Befehl aufgerufen, und die Parameter und Werte, die vom Modell gesendet werden, werden als gebundene Argumente übergeben.  
Das heißt, der Befehl oder das Skript muss in der Lage sein, die Parameter (oder sie dynamisch zu identifizieren) anhand ihres Namens zu empfangen.


All dies geschieht in einer Schleife, die sequenziell durch jedes vom LLM zurückgegebene Tool Calling iteriert.  
Es gibt keine Garantie für die Reihenfolge, in der die Tools ausgeführt werden. Daher sollte man die Reihenfolge niemals voraussetzen, es sei denn, das LLM sendet ein Tool in Reihenfolge.  
Das bedeutet, dass bei zukünftigen Implementierungen mehrere Tool Callings gleichzeitig parallel ausgeführt werden können (z. B. in Jobs).  

Intern erstellt PowershAI ein Standard-Skript-Mapping für die Befehle, die mit `Add-AiTool` hinzugefügt werden.  

Ein Beispiel für die Implementierung von Funktionen, die dieses Format zurückgeben, finden Sie im Provider openai.ps1, bei den Befehlen, die mit Get-OpenaiTool* beginnen

Beachten Sie, dass diese Funktion "Tool Calling" nur mit Modellen funktioniert, die Tool Calling gemäß den gleichen Spezifikationen wie OpenAI unterstützen (sowohl für die Eingabe als auch für die Ausgabe).  


#### WICHTIGE HINWEISE ZUR VERWENDUNG VON TOOLS

Die Funktion "Function Calling" ist zwar leistungsstark, da sie die Ausführung von Code ermöglicht, aber auch gefährlich, SEHR GEFÄHRLICH.  
Seien Sie daher äußerst vorsichtig mit dem, was Sie implementieren und ausführen.
Denken Sie daran, dass PowershAI den Code gemäß den Anweisungen des Modells ausführt. 

Einige Sicherheitstipps:

- Vermeiden Sie es, das Skript mit einem Administratorkonto auszuführen.
- Vermeiden Sie es, Code zu implementieren, der wichtige Daten löscht oder verändert.
- Testen Sie die Funktionen im Vorfeld.
- Fügen Sie keine Module oder Skripte von Drittanbietern hinzu, die Sie nicht kennen oder denen Sie nicht vertrauen.  

Die aktuelle Implementierung führt die Funktion in der gleichen Sitzung und mit den gleichen Anmeldeinformationen wie der angemeldete Benutzer aus.  
Das bedeutet, dass Ihre Daten oder sogar Ihr Computer beschädigt oder kompromittiert werden können, wenn das Modell (absichtlich oder versehentlich) versucht, einen gefährlichen Befehl auszuführen.  

Daher gilt dieser Warnhinweis: Seien Sie äußerst vorsichtig und fügen Sie nur Tools mit Skripten hinzu, denen Sie voll und ganz vertrauen.  

Es ist geplant, zukünftig Mechanismen hinzuzufügen, die die Sicherheit verbessern sollen, z. B. die Isolierung in anderen Runspace-Umgebungen, das Öffnen eines separaten Prozesses mit geringeren Berechtigungen und die Möglichkeit für den Benutzer, diese Einstellungen zu konfigurieren.






<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
