# PowershAI

# RESUMO <!--! @#Short --> 

PowershAI (Powershell + AI) ist ein Modul, das den Zugriff auf KI über Powershell hinzufügt.

# DETALHES  <!--! @#Long --> 

PowershAI ist ein Modul, das Ihrer Powershell-Sitzung KI-Funktionen hinzufügt.  
Das Ziel ist es, komplexe Aufrufe und Behandlungen für die APIs der wichtigsten bestehenden KI-Dienste zu vereinfachen und zu kapseln.  

PowershAI definiert einen Satz von Mustern, die es dem Benutzer ermöglichen, mit LLMs direkt vom Prompt aus zu kommunizieren, oder die Ergebnisse von Befehlen als Kontext in einem Prompt zu verwenden.  
Und über einen standardisierten Satz von Funktionen können verschiedene Anbieter verwendet werden: So können Sie beispielsweise mit GPT-4 oder Gemini Flash mit genau demselben Code kommunizieren.  

Neben dieser Standardisierung stellt PowershAI auch die internen und spezifischen Funktionen für die Verbindung zu den verschiedenen KI-Dienstanbietern bereit.  
So können Sie Skripte anpassen und erstellen, die spezifische Funktionen dieser APIs verwenden.  

Die Architektur von PowershAI definiert das Konzept des "Providers", bei dem es sich um Dateien handelt, die alle Details implementieren, die für die Kommunikation mit ihren jeweiligen APIs erforderlich sind.  
Neue Provider können mit neuen Funktionen hinzugefügt werden, sobald sie verfügbar sind.  

Letztlich haben Sie verschiedene Möglichkeiten, KI in Ihren Skripten zu verwenden. 

Beispiele für bekannte Provider, die bereits vollständig oder teilweise implementiert sind:

- OpenAI 
- Hugging Face 
- Gemini 
- Ollama
- Maritalk (brasilianisches LLM)

Um PowershAI zu verwenden, ist es ganz einfach: 

```powershell 
# Installieren Sie das Modul!
Install-Module -Scope CurrentUser powershai 

# Importieren!
import-module powershai

# Liste der Anbieter 
Get-AiProviders

# Sie sollten die Dokumentation jedes Anbieters konsultieren, um Details zur Verwendung zu erhalten!
# Die Dokumentation kann mit get-help aufgerufen werden 
Get-Help about_NomeProvider

# Beispiel:
Get-Help about_huggingface
```

## Hilfe erhalten  

Trotz des Bemühens, PowershAI so weit wie möglich zu dokumentieren, werden wir wahrscheinlich nicht in der Lage sein, rechtzeitig die gesamte Dokumentation zu erstellen, die zur Klärung von Zweifeln oder zur Erläuterung aller verfügbaren Befehle erforderlich ist.  Daher ist es wichtig, dass Sie die Grundlagen davon selbst verstehen. 

Sie können alle verfügbaren Befehle auflisten, wenn der Befehl `Get-Command -mo powershai` ausgeführt wird.  
Dieser Befehl gibt alle Cmdlets, Aliase und Funktionen zurück, die vom powershAI-Modul exportiert werden.  
Dies ist der einfachste Ausgangspunkt, um herauszufinden, welche Befehle verwendet werden können. Viele Befehle sind selbsterklärend, wenn man sich nur den Namen ansieht.  

Und für jeden Befehl können Sie weitere Details mit `Get-Help -Full NomeComando` erhalten.
Falls der Befehl noch keine vollständige Dokumentation enthält oder Ihnen eine fehlende Information fehlt, können Sie im Git eine Issue erstellen und um weitere Ergänzung bitten.  

Schließlich können Sie den Quellcode von PowershAI untersuchen und nach Kommentaren im Code suchen, die bestimmte Funktionsweisen oder Architekturen auf technischere Weise erläutern.  

Wir werden die Dokumentation aktualisieren, sobald neue Versionen veröffentlicht werden.
Wir ermutigen Sie, zu PowershAI beizutragen, indem Sie Pull Requests oder Issues mit Verbesserungen der Dokumentation einreichen, falls Sie etwas finden, das besser erklärt werden könnte oder noch nicht erklärt wurde.  


## Befehlsstruktur  

PowershAI exportiert verschiedene Befehle, die verwendet werden können.  
Die meisten dieser Befehle enthalten "Ai" oder "Powershai". 
Wir nennen diese Befehle `globale Befehle` von Powershai, da sie keine Befehle für einen bestimmten Provider sind.

Beispiel: `Get-AiProvider`, `Send-PowershaiChat`, `New-PowershaiChat`.  
Die Provider exportieren ebenfalls Befehle, die in der Regel einen Namen des Providers enthalten. Konsultieren Sie die Dokumentation des Providers, um mehr über das exportierte Befehlsmuster zu erfahren.  

Konventionsgemäß sollte kein Provider Befehle implementieren, die "Ai" oder "Powershai" im Namen enthalten, da diese für globale Befehle reserviert sind, unabhängig vom Provider.  
Auch die von den Providern definierten Aliase sollten immer aus mehr als 5 Zeichen bestehen. Kürzere Aliase sind für globale Befehle reserviert.

Sie finden die Dokumentation zu diesen Befehlen in der [Dokumentation zu globalen Befehlen](cmdlets/).  
Sie können den Befehl Get-PowershaiGlobalCommands verwenden, um die Liste zu erhalten!

## Dokumentation der Provider  

Die [Dokumentation der Provider](providers) ist der offizielle Ort, um Hilfe zum Funktionsweise jedes Providers zu erhalten.  
Auf diese Dokumentation kann auch über den Befehl `Get-Help` von Powershell zugegriffen werden.  

Die Dokumentation der Provider wird immer über die Hilfe `about_Powershai_NomeProvider_Topico` bereitgestellt.  
Das Thema `about_Powershai_NomeProvider` ist der Ausgangspunkt und sollte immer die ersten Informationen für die ersten Anwendungen sowie die Erklärungen für die korrekte Verwendung der anderen Themen enthalten.  


## Chats  

Chats sind der wichtigste Ausgangspunkt und ermöglichen es Ihnen, mit den verschiedenen LLMs zu kommunizieren, die von den Providern bereitgestellt werden.  
Weitere Einzelheiten finden Sie in der Dokumentation [Chats](CHATS.about.md). Im Folgenden finden Sie eine kurze Einführung in Chats.

### Mit dem Modell chatten

Sobald die anfängliche Konfiguration des Providers abgeschlossen ist, können Sie mit der Konversation beginnen!  
Die einfachste Möglichkeit, ein Gespräch zu starten, ist die Verwendung des Befehls `Send-PowershaiChat` oder des Alias `ia`:

```powershell
ia "Hallo, kennst du PowerShell?"
```

Dieser Befehl sendet die Nachricht an das Modell des konfigurierten Providers, und die Antwort wird anschließend angezeigt.  
Beachten Sie, dass die Antwortzeit von den Fähigkeiten des Modells und dem Netzwerk abhängt.  

Sie können die Pipeline verwenden, um die Ergebnisse anderer Befehle direkt als Kontext für die IA einzuspielen:

```powershell
1..100 | Get-Random -count 10 | ia "Erzähl mir Kuriositäten über diese Zahlen"
```  
Der obige Befehl generiert eine Sequenz von 1 bis 100 und spielt jede Zahl in die Powershell-Pipeline.  
Dann filtert der Befehl Get-Random nur 10 dieser Zahlen zufällig.  
Und schließlich wird diese Sequenz (auf einmal) an die IA übergeben und mit der Nachricht gesendet, die im Parameter angegeben wurde.  

Sie können den Parameter `-ForEach` verwenden, damit die IA jede Eingabe einzeln verarbeitet, zum Beispiel:

```powershell
1..100 | Get-Random -count 10 | ia -ForEach "Erzähl mir Kuriositäten über diese Zahlen"
```  

Der Unterschied zu diesem obigen Befehl besteht darin, dass die IA 10-mal aufgerufen wird, einmal für jede Zahl.  
Im vorherigen Beispiel wurde sie nur einmal aufgerufen, mit allen 10 Zahlen.  
Der Vorteil dieser Methode besteht darin, dass der Kontext reduziert wird, aber sie kann länger dauern, da mehr Anfragen gestellt werden.  
Testen Sie sie entsprechend Ihren Bedürfnissen!

### Objektmodus  

Standardmäßig gibt der Befehl `ia` nichts zurück. Sie können dieses Verhalten jedoch ändern, indem Sie den Parameter `-Object` verwenden.  
Wenn dieser Parameter aktiviert ist, fordert er das LLM auf, das Ergebnis in JSON zu generieren, und schreibt die Rückgabe in die Pipeline.  
Das bedeutet, dass Sie etwas Ähnliches tun können:

```powershell
ia -Obj "5 zufällige Zahlen, wobei der Wert ausgeschrieben ist"

# oder mit dem Alias, io/powershellgallery/dt/powershai

io "5 zufällige Zahlen, wobei der Wert ausgeschrieben ist"
```  

**WICHTIG: Beachten Sie, dass nicht jeder Provider diesen Modus unterstützen kann, da das Modell JSON unterstützen muss! Wenn Sie Fehler erhalten, überprüfen Sie, ob derselbe Befehl mit einem Modell von OpenAI funktioniert. Sie können auch eine Issue erstellen.**


## Konfigurationen speichern  

PowershAI ermöglicht es, eine Reihe von Konfigurationen anzupassen, wie z. B. Chat-Parameter, Authentifizierungstoken usw.  
Wenn Sie eine Konfiguration ändern, wird diese nur im Arbeitsspeicher Ihrer Powershell-Sitzung gespeichert.  
Wenn Sie die Sitzung schließen und erneut öffnen, gehen alle vorgenommenen Konfigurationen verloren.  

Damit Sie nicht jedes Mal Token generieren müssen, stellt Powershai 2 Befehle zum Exportieren und Importieren von Konfigurationen bereit.  
Der Befehl `Export-PowershaiSettings` exportiert die Konfigurationen in eine Datei im Profilverzeichnis des angemeldeten Benutzers.  
Da die exportierten Daten sensibel sein können, müssen Sie ein Kennwort angeben, das zum Generieren eines Verschlüsselungsschlüssels verwendet wird.  
Die exportierten Daten werden mit AES-256 verschlüsselt.  
Sie können sie mit `Import-PowershaiSettings` importieren. Sie müssen das Kennwort angeben, das Sie zum Exportieren verwendet haben.  

Beachten Sie, dass dieses Kennwort nirgendwo gespeichert wird, Sie sind also dafür verantwortlich, es sich zu merken oder an einem sicheren Ort zu speichern.

## Kosten  

Es ist wichtig sich daran zu erinnern, dass einige Provider für die Nutzung der Dienste Gebühren erheben können.  
PowershAI führt keine Kostenverwaltung durch.  Es kann Daten in Prompts, Parameter usw. einfügen.  
Sie sollten die Überwachung mithilfe der Tools durchführen, die der Anbieter auf seiner Website für diesen Zweck bereitstellt.  

Zukünftige Versionen können Befehle oder Parameter enthalten, die zur besseren Steuerung beitragen, aber im Moment muss der Benutzer die Überwachung selbst durchführen.  



### Exportieren und Importieren von Konfigurationen und Token

Um die Wiederverwendung von Daten (Token, Standardmodelle, Chat-Verlauf usw.) zu erleichtern, ermöglicht PowershAI das Exportieren der Sitzung.  
Verwenden Sie dazu den Befehl `Export-PowershaiSettings`. Sie müssen ein Kennwort angeben, das zum Erstellen eines Schlüssels und zur Verschlüsselung dieser Datei verwendet wird.  
Nur mit diesem Kennwort können Sie es wieder importieren. Verwenden Sie zum Importieren den Befehl `Import-PowershaiSettings`.  
Standardmäßig werden Chats nicht exportiert. Um sie zu exportieren, können Sie den Parameter -Chats hinzufügen: `Export-PowershaiSettings -Chats`.  
Beachten Sie, dass dies die Datei größer machen und die Export-/Importzeit verlängern kann.  Der Vorteil ist, dass Sie die Konversation zwischen verschiedenen Sitzungen fortsetzen können.  
Diese Funktion wurde ursprünglich entwickelt, um zu vermeiden, dass jedes Mal, wenn PowershAI verwendet wird, API-Schlüssel generiert werden müssen. Damit generieren Sie Ihre API-Schlüssel einmal pro Provider und exportieren sie, wenn Sie sie aktualisieren. Da sie passwortgeschützt sind, können Sie sie sicher in einer Datei auf Ihrem Computer speichern.  
Weitere Informationen zur Verwendung erhalten Sie in der Hilfe zum Befehl.


# BEISPIELE <!--! @#Ex -->

## Grundlegende Verwendung 

Die Verwendung von PowershAI ist sehr einfach. Das folgende Beispiel zeigt, wie Sie es mit OpenAI verwenden können:

```powershell 
# Ändern Sie den aktuellen Provider zu OpenAI
Set-AiProvider openai 

# Konfigurieren Sie das Authentifizierungstoken (Sie müssen das Token auf der Website platform.openai.com generieren)
Set-OpenaiToken 

# Verwenden Sie einen der Befehle, um einen Chat zu starten!  ia ist ein Alias für Send-PowershaiChat, der eine Nachricht an den Standard-Chat sendet!
ia "Hallo, ich spreche mit dir von Powershaui aus!"
```

## Konfigurationen exportieren 


```powershell 
# Definieren Sie ein beliebiges Token, z. B. 
Set-OpenaiToken 

# Nachdem der obige Befehl ausgeführt wurde, können Sie ihn einfach exportieren!
Export-PowershaiSettings

# Sie müssen das Kennwort angeben!
```

## Konfigurationen importieren 


```powershell 
import-module powershai 

# Importieren Sie die Konfigurationen 
Import-PowershaiSettings # Der Befehl fordert das zum Exportieren verwendete Kennwort an
```

# Wichtige Informationen <!--! @#Note -->

PowershAI verfügt über eine Reihe von verfügbaren Befehlen.  
Jeder Provider stellt eine Reihe von Befehlen mit einem bestimmten Namensmuster bereit.  
Sie sollten immer die Dokumentation des Providers lesen, um weitere Details zu seiner Verwendung zu erhalten.  

# Fehlerbehebung <!--! @#Troub -->

Trotz des großen Umfangs des Codes und der bereits vorhandenen Funktionalität ist PowershAI ein neues Projekt, das sich in der Entwicklung befindet.  
Es können einige Fehler auftreten, und in dieser Phase ist es wichtig, dass Sie uns über Issues im offiziellen Repository unter https://github.com/rrg92/powershai  helfen, indem Sie uns darüber informieren.  

Wenn Sie ein Problem beheben möchten, empfehle ich, die folgenden Schritte auszuführen:

- Verwenden Sie das Debuggen, um Ihnen zu helfen. Befehle wie Set-PSBreakpoint sind einfach in der Befehlszeile aufzurufen und können Ihnen Zeit sparen.
- Einige Funktionen zeigen nicht den vollständigen Fehler an. Sie können die Variable $error verwenden und auf die letzte zugreifen. Beispiel:  
```
$e = $error[0];
$e.ErrorRecord.ScriptStackTrace # Dies hilft, die genaue Zeile zu finden, in der die Ausnahme aufgetreten ist!
```

# Siehe auch <!--! @#Also -->

- Video zum Thema Verwendung des Hugging Face-Providers: https://www.youtube.com/watch?v=DOWb8MTS5iU
- Weitere Informationen zur Verwendung der Cmdlets finden Sie in der Dokumentation der einzelnen Provider.

# Schlagwörter <!--! @#Kw -->

- Künstliche Intelligenz
- KI





<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
