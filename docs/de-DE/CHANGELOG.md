# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.2]

### Added <!--AiDoc:Translator:IgnoreLine-->
- **GROQ PROVIDER**: Groq zu den automatischen Tests hinzugefügt.

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #39: Fehler im Groq-Provider behoben, der Systemmeldungen betraf.
- **COHERE PROVIDER**: Fehler im Zusammenhang mit Modellnachrichten behoben, wenn Antworten von Tool-Calls vorhanden waren.


## [v0.7.1]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Issue #36: Chats wurden jedes Mal neu erstellt, wodurch der Verlauf bei Verwendung mehrerer Chats nicht korrekt beibehalten wurde!
- **OPENAI PROVIDER**: Ergebnis von `Get-AiEmbeddings` korrigiert.

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fehler im Hugging Face-Provider aufgrund von Weiterleitungen behoben.
- Die Installation von Modulen für Tests mit Docker Compose wurde korrigiert.
- Leistungsprobleme bei der Konvertierung von Tools aufgrund einer möglichen großen Anzahl von Befehlen in einer Sitzung behoben. Verwendet jetzt dynamische Module. Siehe `ConvertTo-OpenaiTool`.
- Inkompatibilitätsprobleme zwischen der GROQ-API und OpenAI behoben. `message.refusal` wird nicht mehr akzeptiert.
- Kleinere Fehler im PowerShell Core für Linux behoben.
- **OPENAI PROVIDER**: Ausnahmecode behoben, der durch das Fehlen eines Standardmodells verursacht wurde.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NEUER PROVIDER**: Willkommen Azure 🎉
- **NEUER PROVIDER**: Willkommen Cohere 🎉
- Die Funktion `AI Credentials` hinzugefügt - eine neue Standardmethode für Benutzer zum Definieren von Anmeldeinformationen, die es Anbietern ermöglicht, Anmeldeinformationen von Benutzern anzufordern.
- Anbieter migriert, um `AI Credentials` zu verwenden, wobei die Kompatibilität mit älteren Befehlen erhalten bleibt.
- Neues Cmdlet `Confirm-PowershaiObjectSchema` zur Validierung von Schemata mithilfe von OpenAPI mit einer mehr "PowerShell-artigen" Syntax.
- Unterstützung für HTTP-Weiterleitungen in der HTTP-Bibliothek hinzugefügt.
- Mehrere neue Tests mit Pester hinzugefügt, die von grundlegenden Unit-Tests bis hin zu komplexeren Fällen wie echten LLM-Tool-Calls reichen.
- Neues Cmdlet `Switch-PowershaiSettings` ermöglicht das Umschalten von Einstellungen und das Erstellen von Chats, Standardanbietern, Modellen usw., als wären sie unterschiedliche Profile.
- **Wiederholungslogik**: `Enter-PowershaiRetry` hinzugefügt, um Skripte basierend auf Bedingungen erneut auszuführen.
- **Wiederholungslogik**: Wiederholungslogik in `Get-AiChat` hinzugefügt, um die Eingabeaufforderung einfach erneut an das LLM zu senden, falls die vorherige Antwort nicht den Erwartungen entspricht.
- Das neue Cmdlet `Enter-AiProvider` ermöglicht nun die Ausführung von Code unter einem bestimmten Anbieter. Cmdlets, die von einem Anbieter abhängen, verwenden immer den zuletzt "eingegebenen" Anbieter anstelle des aktuellen Anbieters.
- Anbieterstapel (Push/Pop): Ähnlich wie bei `Push-Location` und `Pop-Location` können Sie jetzt Anbieter hinzufügen und entfernen, um schneller zwischen der Ausführung von Code in verschiedenen Anbietern zu wechseln.
- Neues Cmdlet `Get-AiEmbeddings`: Standard-Cmdlets zum Abrufen von Einbettungen aus einem Text hinzugefügt, die es Anbietern ermöglichen, die Generierung von Einbettungen offenzulegen, und dem Benutzer einen Standardmechanismus zum Generieren bieten.
- Neues Cmdlet `Reset-AiDefaultModel`, um das Standardmodell zu deaktivieren.
- Die Parameter `ProviderRawParams` zu `Get-AiChat` und `Invoke-AiChat` hinzugefügt, um die spezifischen Parameter in der API pro Anbieter zu überschreiben.
- **HUGGINGFACE PROVIDER**: Neue Tests hinzugefügt, die einen echten exklusiven Hugging Face-Space verwenden, der als Submodul dieses Projekts verwaltet wird. Dies ermöglicht das gleichzeitige Testen mehrerer Aspekte: Gradio-Sitzungen und Hugging Face-Integration.
- **HUGGINGFACE PROVIDER**: Neues Cmdlet: Find-HuggingFaceModel, um Modelle im Hub basierend auf einigen Filtern zu suchen!
- **OPENAI PROVIDER**: Ein neues Cmdlet zum Generieren von Tool-Calls hinzugefügt: `ConvertTo-OpenaiTool`, das in Skriptblöcken definierte Tools unterstützt.
- **OLLAMA PROVIDER**: Neues Cmdlet `Get-OllamaEmbeddings` hinzugefügt, um Einbettungen mit Ollama zurückzugeben.
- **OLLAMA PROVIDER**: Neues Cmdlet `Update-OllamaModel`, um Ollama-Modelle (Pull) direkt aus PowerShell herunterzuladen.
- **OLLAMA PROVIDER**: Automatische Erkennung von Tools mithilfe der Ollama-Metadaten.
- **OLLAMA PROVIDER**: Cache für Modellmetadaten und neues Cmdlet `Reset-OllamaPowershaiCache`, um den Cache zu leeren, wodurch viele Details von Ollama-Modellen abgefragt werden können, während die Leistung für die wiederholte Verwendung des Befehls erhalten bleibt.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: Der Chat-Parameter `ContextFormatter` wurde in `PromptBuilder` umbenannt.
- Die Standardanzeige (formats.ps1xml) einiger Cmdlets wie `Get-AiModels` wurde geändert.
- Verbesserte detaillierte Protokollierung beim Entfernen des alten Verlaufs aufgrund von `MaxContextSize` in Chats.
- Neue Art und Weise, wie PowershAI-Einstellungen gespeichert werden, indem ein Konzept des "Einstellungsspeichers" eingeführt wird, das den Austausch von Einstellungen ermöglicht (z. B. für Tests).
- Aktualisierte Emojis, die zusammen mit dem Modellnamen angezeigt werden, wenn der Befehl Send-PowershaiChat verwendet wird.
- Verbesserungen bei der Verschlüsselung des Exports/Imports von Einstellungen (Export=-PowershaiSettings). Verwendet jetzt Schlüsselleitungen und Salt.
- Verbesserung der Rückgabe der *_Chat-Schnittstelle, um dem OpenAI-Standard besser zu entsprechen.
- Die Option `IsOpenaiCompatible` für Anbieter hinzugefügt. Anbieter, die OpenAI-Cmdlets wiederverwenden möchten, sollten dieses Flag auf `true` setzen, damit sie ordnungsgemäß funktionieren.
- Verbesserte Fehlerbehandlung von `Invoke-AiChatTools` bei der Verarbeitung von Tool-Calls.
- **GOOGLE PROVIDER**: Das Cmdlet `Invoke-GoogleApi` hinzugefügt, um direkte API-Aufrufe durch Benutzer zu ermöglichen.
- **HUGGING FACE PROVIDER**: Kleine Anpassungen an der Art und Weise, wie das Token in API-Anfragen eingefügt wird.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` und `Get-OpenaiToolFromScript` verwenden jetzt `ConvertTo-OpenaiTool`, um die Konvertierung von Befehlen in OpenAI-Tools zu zentralisieren.
- **GROQ PROVIDER**: Standardmodell von `llama-3.1-70b-versatile` auf `llama-3.2-70b-versatile` aktualisiert.
- **OLLAMA PROVIDER**: Get-AiModels enthält jetzt Modelle, die Tools unterstützen, da der Anbieter den Endpunkt /api/show verwendet, um weitere Details zu den Modellen abzurufen, wodurch die Unterstützung für Tools überprüft werden kann.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fehler in der Funktion `New-GradioSessionApiProxyFunction` im Zusammenhang mit einigen internen Funktionen behoben.
- Unterstützung für Gradio 5 hinzugefügt, die aufgrund von Änderungen an den API-Endpunkten erforderlich ist.

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Unterstützung für Bilder in `Send-PowershaiChat` für die Anbieter OpenAI und Google.
- Ein experimenteller Befehl, `Invoke-AiScreenshots`, der Unterstützung für das Erstellen und Analysieren von Screenshots hinzufügt!
- Unterstützung für Tool-Calls im Google-Provider.
- CHANGELOG wurde gestartet.
- TAB-Unterstützung für Set-AiProvider hinzugefügt.
- Grundlegende Unterstützung für strukturierte Ausgaben zum Parameter `ResponseFormat` des Cmdlets `Get-AiChat` hinzugefügt. Dies ermöglicht die Übergabe einer Hashtable, die das OpenAPI-Schema des Ergebnisses beschreibt.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: Die Eigenschaft `content` von OpenAI-Nachrichten wird jetzt als Array gesendet, um sie an die Spezifikationen für andere Medientypen anzupassen. Dies erfordert die Aktualisierung von Skripten, die vom vorherigen Einzel-String-Format und von älteren Versionen von Anbietern abhängen, die diese Syntax nicht unterstützen.
- Der Parameter `RawParams` von `Get-AiChat` wurde korrigiert. Sie können jetzt API-Parameter an den jeweiligen Anbieter übergeben, um die strikte Kontrolle über das Ergebnis zu haben.
- DOC-Aktualisierungen: Neue mit AiDoc übersetzte Dokumente und Aktualisierungen. Kleine Korrektur in AiDoc.ps1, um einige Markdown-Syntaxbefehle nicht zu übersetzen.


### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Die Sicherheitseinstellungen wurden geändert und die Groß-/Kleinschreibung verbessert. Dies wurde nicht validiert, was zu einem Fehler führte.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0
[v0.7.1]: https://github.com/rrg92/powershai/releases/tag/v0.7.1
[v0.7.2]: https://github.com/rrg92/powershai/releases/tag/v0.7.2



<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI_
<!--PowershaiAiDocBlockEnd-->
