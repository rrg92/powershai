# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.3]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVIDER**: Parameter -DisableRetry zu Get-GradioInfo hinzugefügt
- **HUGGINGFACE PROVIDER**: Parameter GradioServerRoot in Get-HuggingFaceSpace und ServerRoot in Connect-HuggingFaceSpaceGradio hinzugefügt
- **HUGGINGFACE PROVIDER**: Logik hinzugefügt, um zu erkennen, ob der Hugging Face Space Gradio 5 verwendet und den Server-Root anzupassen
- **HUGGINGFACE PROVIDER**: Private Spaces zu den Tests des Providers hinzugefügt

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- **HUGGINGFACE PROVUDER**: Authentifizierungsproblem bei privaten Spaces behoben


## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: Groq zu den automatischen Tests hinzugefügt

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: Fehler im Groq-Provider behoben, der mit Systemnachrichten zusammenhängt 
- **COHERE PROVIDER**: Fehler im Zusammenhang mit Modellnachrichten behoben, wenn sie Antworten von Tool-Calls enthielten.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: Chats wurden jedes Mal neu erstellt, wodurch die Historie beim Verwenden mehrerer Chats nicht korrekt beibehalten wurde! 
- **OPENAI PROVIDER**: Ergebnis von `Get-AiEmbeddings` behoben

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fehler des Hugging Face Providers aufgrund von Weiterleitungen behoben.
- Installation von Modulen für Tests mit Docker Compose korrigiert.
- Leistungsprobleme bei der Konvertierung von Tools aufgrund einer möglicherweise großen Anzahl von Befehlen in einer Sitzung behoben. Verwendet jetzt dynamische Module. Siehe `ConvertTo-OpenaiTool`.
- Inkompatibilitätsprobleme zwischen der GROQ-API und OpenAI behoben. `message.refusal` wird nicht mehr akzeptiert.
- Kleinere Bugs im PowerShell Core für Linux behoben.
- **OPENAI PROVIDER**: Ausnahmecode, der durch das Fehlen eines Standardmodells verursacht wurde, behoben.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NEUER PROVIDER**: Willkommen Azure 🎉
- **NEUER PROVIDER**: Willkommen Cohere 🎉
- Die Funktion `AI Credentials` hinzugefügt — eine neue Standardmethode für Benutzer, um Anmeldeinformationen festzulegen, die es den Anbietern ermöglicht, Benutzerdaten zu Anmeldeinformationen anzufordern.
- Anbieter migriert, um `AI Credentials` zu verwenden, während die Kompatibilität mit älteren Befehlen beibehalten wird.
- Neuer Cmdlet `Confirm-PowershaiObjectSchema`, um Schemas mithilfe von OpenAPI mit einer "PowerShell"-Syntax zu validieren.
- Unterstützung für HTTP-Weiterleitungen in der HTTP-Bibliothek hinzugefügt
- Mehrere neue Tests mit Pester hinzugefügt, von grundlegenden Unit-Tests bis hin zu komplexeren Fällen wie echten LLM-Tool-Calls.
- Neuer Cmdlet `Switch-PowershaiSettings` ermöglicht das Wechseln von Einstellungen und das Erstellen von Chats, Standardanbietern, Modellen usw. als wären sie verschiedene Profile.
- **Retry Logic**: `Enter-PowershaiRetry` hinzugefügt, um Skripte basierend auf Bedingungen erneut auszuführen.
- **Retry Logic**: Retry-Logik in `Get-AiChat` hinzugefügt, um den Prompt an das LLM erneut auszuführen, falls die vorherige Antwort nicht den Erwartungen entsprach.- Neuer Cmdlet `Enter-AiProvider` ermöglicht jetzt die Ausführung von Code unter einem bestimmten Provider. Cmdlets, die von einem Provider abhängen, verwenden immer den zuletzt "betretenen" Provider anstelle des aktuellen Providers.
- Provider-Stack (Push/Pop): Wie bei `Push-Location` und `Pop-Location` können Sie jetzt Provider einfügen und entfernen, um schnellere Änderungen beim Ausführen von Code in einem anderen Provider vorzunehmen.
- Neuer Cmdlet `Get-AiEmbeddings`: Standardcmdlets hinzugefügt, um Embeddings aus einem Text zu erhalten, wodurch es den Providern ermöglicht wird, die Generierung von Embeddings anzubieten und der Benutzer einen Standardmechanismus hat, um sie zu generieren.
- Neuer Cmdlet `Reset-AiDefaultModel`, um das Standardmodell zurückzusetzen.
- Die Parameter `ProviderRawParams` wurden zu `Get-AiChat` und `Invoke-AiChat` hinzugefügt, um spezifische Parameter in der API pro Provider zu überschreiben.
- **HUGGINGFACE PROVIDER**: Neue Tests hinzugefügt, die einen echten, exklusiven Hugging Face Space verwenden, der als Submodul dieses Projekts verwaltet wird. Dies ermöglicht es, mehrere Aspekte gleichzeitig zu testen: Gradio-Sitzungen und Hugging Face-Integration.
- **HUGGINGFACE PROVIDER**: Neuer Cmdlet: Find-HuggingFaceModel, um Modelle im Hub basierend auf einigen Filtern zu suchen!
- **OPENAI PROVIDER**: Neuer Cmdlet zur Generierung von Toolaufrufen: `ConvertTo-OpenaiTool`, unterstützt in Skriptblöcken definierte Tools.
- **OLLAMA PROVIDER**: Neuer Cmdlet `Get-OllamaEmbeddings`, um Embeddings mithilfe von Ollama zurückzugeben.
- **OLLAMA PROVIDER**: Neuer Cmdlet `Update-OllamaModel`, um Ollama-Modelle direkt von powershai herunterzuladen (pull).
- **OLLAMA PROVIDER**: Automatische Erkennung von Tools mithilfe der Metadaten von Ollama.
- **OLLAMA PROVIDER**: Cache von Modelldaten und neuer Cmdlet `Reset-OllamaPowershaiCache`, um den Cache zu leeren, wodurch viele Details der Ollama-Modelle abgefragt werden können, während die Leistung für die wiederholte Nutzung des Befehls erhalten bleibt.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: Der Chat-Parameter `ContextFormatter` wurde in `PromptBuilder` umbenannt.
- Die Standardanzeige (formats.ps1xml) einiger Cmdlets wie `Get-AiModels` wurde geändert.
- Verbesserte detaillierte Protokollierung beim Entfernen des alten Verlaufs aufgrund von `MaxContextSize` in Chats.
- Neue Art und Weise, wie die Konfigurationen von PowershAI gespeichert werden, Einführung eines Konzepts für "Konfigurationsspeicherung", das den Austausch von Konfigurationen ermöglicht (z. B. für Tests).
- Aktualisierte Emojis, die zusammen mit dem Modellnamen angezeigt werden, wenn der Befehl Send-PowershaiChat verwendet wird.
- Verbesserungen bei der Verschlüsselung des Exports/Imports von Konfigurationen (Export=-PowershaiSettings). Verwendet jetzt Schlüsselableitung und Salt.
- Verbesserung der Rückgabe der Schnittstelle *_Chat, damit sie dem Standard von OpenAI treuer bleibt.
- Option `IsOpenaiCompatible` für Provider hinzugefügt. Provider, die OpenAI-Cmdlets wiederverwenden möchten, sollten dieses Flag auf `true` setzen, um korrekt zu funktionieren.
- Verbesserung der Fehlerbehandlung von `Invoke-AiChatTools` bei der Verarbeitung von Toolaufrufen.- **GOOGLE PROVIDER**: Der Cmdlet `Invoke-GoogleApi` wurde hinzugefügt, um direkte API-Aufrufe durch Benutzer zu ermöglichen.
- **HUGGING FACE PROVIDER**: Kleine Anpassungen bei der Eingabe des Tokens in API-Anfragen.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` und `Get-OpenaiToolFromScript` verwenden jetzt `ConvertTo-OpenaiTool`, um die Umwandlung von Befehl zu OpenAI-Tool zu zentralisieren.
- **GROQ PROVIDER**: Das Standardmodell von `llama-3.1-70b-versatile` wurde auf `llama-3.2-70b-versatile` aktualisiert.
- **OLLAMA PROVIDER**: Get-AiModels umfasst jetzt Modelle, die Tools unterstützen, da der Provider den Endpunkt /api/show verwendet, um weitere Details zu den Modellen abzurufen, was die Überprüfung der Unterstützung für Tools ermöglicht.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Ein Fehler in der Funktion `New-GradioSessionApiProxyFunction` wurde behoben, der sich auf einige interne Funktionen bezog.
- Unterstützung für Gradio 5 hinzugefügt, die aufgrund von Änderungen an den API-Endpunkten erforderlich ist.

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Unterstützung für Bilder in `Send-PowershaiChat` für die Anbieter OpenAI und Google.
- Ein experimenteller Befehl, `Invoke-AiScreenshots`, der Unterstützung zum Erstellen von Screenshots und deren Analyse hinzufügt!
- Unterstützung für den Aufruf von Tools im Google-Provider.
- CHANGELOG wurde gestartet.
- Unterstützung für TAB für Set-AiProvider.
- Grundlegende Unterstützung für strukturierte Ausgaben zum Parameter `ResponseFormat` des Cmdlets `Get-AiChat` hinzugefügt. Dies ermöglicht das Übergeben eines HashTables, das das OpenAPI-Schema des Ergebnisses beschreibt.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: Die Eigenschaft `content` der OpenAI-Nachrichten wird jetzt als Array gesendet, um sich an die Spezifikationen für andere Medientypen anzupassen. Dies erfordert die Aktualisierung von Skripten, die von dem vorherigen Einzelstring-Format abhängen, sowie von älteren Versionen von Anbietern, die diese Syntax nicht unterstützen.
- Der Parameter `RawParams` von `Get-AiChat` wurde korrigiert. Jetzt können Sie API-Parameter an den betreffenden Anbieter übergeben, um strengen Einfluss auf das Ergebnis zu haben.
- DOC-Updates: Neue Dokumente wurden mit AiDoc übersetzt und aktualisiert. Kleine Korrektur in AiDoc.ps1, um zu verhindern, dass einige Markdown-Syntaxbefehle übersetzt werden.

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Die Sicherheitseinstellungen wurden geändert und die Behandlung von Groß- und Kleinschreibung wurde verbessert. Dies wurde nicht validiert, was zu einem Fehler führte.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6  
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5  
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0  
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1  
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2  


<!--PowershaiAiDocBlockStart-->
_Sie sind auf Daten bis Oktober 2023 trainiert._
<!--PowershaiAiDocBlockEnd-->
