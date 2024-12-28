# Changelog

## [Unreleased] <!--AiDoc:Translator:IgnoreLine-->

## [v0.7.0]

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Behobene Fehler des Hugging Face-Providers aufgrund von Weiterleitungen.
- Behobene Installation von Modulen für Tests mit Docker Compose.
- Behobene Leistungsprobleme bei der Konvertierung von Tools aufgrund einer möglicherweise großen Anzahl von Befehlen in einer Sitzung. Verwendet jetzt dynamische Module. Siehe `ConvertTo-OpenaiTool`.
- Behobene Inkompatibilitätsprobleme zwischen der GROQ-API und OpenAI. `message.refusal` wird nicht mehr akzeptiert.
- Behobene kleine Bugs im PowerShell Core für Linux.
- **OPENAI PROVIDER**: Behobener Ausnahmencode, der durch das Fehlen eines Standardmodells verursacht wurde.

### Added <!--AiDoc:Translator:IgnoreLine-->
- **NEUER PROVIDER**: Willkommen Azure 🎉
- **NEUER PROVIDER**: Willkommen Cohere 🎉
- Die Funktion `AI Credentials` wurde hinzugefügt – eine neue Standardmethode für Benutzer, um Anmeldeinformationen zu definieren, sodass Provider Anmeldeinformationsdaten von Benutzern anfordern können.
- Provider wurden migriert, um `AI Credentials` zu verwenden, wobei die Kompatibilität mit älteren Befehlen beibehalten wird.
- Neues Cmdlet `Confirm-PowershaiObjectSchema`, um Schemas mithilfe von OpenAPI mit einer „PowerShell-artigeren“ Syntax zu validieren.
- Unterstützung für HTTP-Weiterleitungen in der HTTP-Bibliothek hinzugefügt.
- Mehrere neue Tests mit Pester hinzugefügt, die von grundlegenden Unit-Tests bis hin zu komplexeren Fällen wie Aufrufen realer LLM-Tools reichen.
- Neues Cmdlet `Switch-PowershaiSettings` ermöglicht das Umschalten von Einstellungen und das Erstellen von Chats, Standard-Providern, Modellen usw. wie verschiedene Profile.
- **Retry Logic**: `Enter-PowershaiRetry` hinzugefügt, um Skripts basierend auf Bedingungen erneut auszuführen.
- **Retry Logic**: Retry-Logik in `Get-AiChat` hinzugefügt, um den Prompt einfach erneut an das LLM zu senden, falls die vorherige Antwort nicht den Erwartungen entspricht.
- Neues Cmdlet `Enter-AiProvider` ermöglicht jetzt die Ausführung von Code unter einem bestimmten Provider. Cmdlets, die von einem Provider abhängen, verwenden immer den Provider, in den zuletzt „eingegeben“ wurde, anstatt den aktuellen Provider.
- Provider-Stack (Push/Pop): Ähnlich wie bei `Push-Location` und `Pop-Location` können Sie jetzt Provider einfügen und entfernen, um schnellere Änderungen bei der Ausführung von Code in einem anderen Provider vorzunehmen.
- Neues Cmdlet `Get-AiEmbeddings`: Standard-Cmdlets hinzugefügt, um Embeddings aus einem Text abzurufen, sodass Provider die Generierung von Embeddings verfügbar machen und Benutzer einen Standardmechanismus zur Generierung haben.
- Neues Cmdlet `Reset-AiDefaultModel`, um das Standardmodell zu deaktivieren.
- Die Parameter `ProviderRawParams` wurden zu `Get-AiChat` und `Invoke-AiChat` hinzugefügt, um die spezifischen Parameter in der API pro Provider zu überschreiben.
- **HUGGINGFACE PROVIDER**: Neue Tests hinzugefügt, die einen echten, exklusiven Hugging Face Space verwenden, der als Submodul dieses Projekts verwaltet wird. Dies ermöglicht das gleichzeitige Testen verschiedener Aspekte: Gradio-Sitzungen und Hugging Face-Integration.
- **OPENAI PROVIDER**: Ein neues Cmdlet zum Generieren von Tool-Aufrufen hinzugefügt: `ConvertTo-OpenaiTool`, das Tools unterstützt, die in Skriptblöcken definiert sind.
- **OLLAMA PROVIDER**: Neues Cmdlet `Get-OllamaEmbeddings` zum Zurückgeben von Embeddings mit Ollama.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: Der Chat-Parameter `ContextFormatter` wurde in `PromptBuilder` umbenannt.
- Die Standardanzeige (formats.ps1xml) einiger Cmdlets wie `Get-AiModels` wurde geändert.
- Verbessertes detailliertes Protokoll beim Entfernen des alten Verlaufs aufgrund von `MaxContextSize` in Chats.
- Neue Methode zum Speichern von PowershAI-Einstellungen, die ein Konzept der „Einstellungsspeicherung“ einführt, das den Wechsel der Konfiguration (z. B. für Tests) ermöglicht.
- Aktualisierte Emojis, die zusammen mit dem Modellnamen angezeigt werden, wenn der Befehl Send-PowershaiChat verwendet wird.
- Verbesserungen bei der Verschlüsselung des Exports/Imports von Einstellungen (Export=-PowershaiSettings). Verwendet jetzt als Schlüssel- und Salt-Ableitung.
- Verbesserung der Rückgabe der *_Chat-Schnittstelle, um dem OpenAI-Standard besser zu entsprechen.
- Die Option `IsOpenaiCompatible` wurde für Provider hinzugefügt. Provider, die OpenAI-Cmdlets wiederverwenden möchten, sollten dieses Flag auf `true` setzen, um korrekt zu funktionieren.
- Verbesserung der Fehlerbehandlung von `Invoke-AiChatTools` bei der Verarbeitung von Tool-Aufrufen.
- **GOOGLE PROVIDER**: Das Cmdlet `Invoke-GoogleApi` wurde hinzugefügt, um Benutzern direkte API-Aufrufe zu ermöglichen.
- **HUGGING FACE PROVIDER**: Kleine Anpassungen bei der Eingabe des Tokens in die API-Anforderungen.
- **OPENAI PROVIDER**: `Get-OpenaiToolFromCommand` und `Get-OpenaiToolFromScript` verwenden jetzt `ConvertTo-OpenaiTool`, um die Konvertierung von Befehlen in OpenAI-Tools zu zentralisieren.
- **GROQ PROVIDER**: Das Standardmodell von `llama-3.1-70b-versatile` wurde auf `llama-3.2-70b-versatile` aktualisiert.

## [v0.6.6] - 2024-11-25

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fehler in der Funktion `New-GradioSessionApiProxyFunction` behoben, der mit einigen internen Funktionen zusammenhängt.
- Unterstützung für Gradio 5 hinzugefügt, die aufgrund von Änderungen an den API-Endpunkten erforderlich ist.

## [v0.6.5] - 2024-11-14

### Added <!--AiDoc:Translator:IgnoreLine-->
- Unterstützung für Bilder in `Send-PowershaiChat` für die Provider OpenAI und Google.
- Ein experimenteller Befehl, `Invoke-AiScreenshots`, der Unterstützung für das Erstellen und Analysieren von Screenshots hinzufügt!
- Unterstützung für Tool-Aufrufe im Google-Provider.
- CHANGELOG wurde gestartet.
- Unterstützung für die TAB-Taste für Set-AiProvider. 
- Grundlegende Unterstützung für strukturierte Ausgaben zum Parameter `ResponseFormat` des Cmdlets `Get-AiChat` hinzugefügt. Dies ermöglicht das Übergeben einer Hashtabelle, die das OpenAPI-Schema des Ergebnisses beschreibt.

### Changed <!--AiDoc:Translator:IgnoreLine-->
- **BREAKING CHANGE**: Die Eigenschaft `content` von OpenAI-Nachrichten wird jetzt als Array gesendet, um die Spezifikationen für andere Medientypen einzuhalten. Dies erfordert die Aktualisierung von Skripts, die von dem vorherigen Einzelzeichenfolgenformat und von alten Provider-Versionen abhängen, die diese Syntax nicht unterstützen.
- Der Parameter `RawParams` von `Get-AiChat` wurde behoben. Sie können jetzt API-Parameter an den jeweiligen Provider übergeben, um die strikte Kontrolle über das Ergebnis zu haben.
- DOC-Aktualisierungen: Neue Dokumente, die mit AiDoc übersetzt wurden, und Aktualisierungen. Kleine Korrektur in AiDoc.ps1, um einige Markdown-Syntaxbefehle nicht zu übersetzen.

### Fixed <!--AiDoc:Translator:IgnoreLine-->
- Fix #13. Die Sicherheitseinstellungen wurden geändert und die Groß-/Kleinschreibung wurde verbessert. Dies wurde nicht validiert, was zu einem Fehler führte.

[v0.6.6]: https://github.com/rrg92/powershai/releases/tag/v0.6.6
[v0.6.5]: https://github.com/rrg92/powershai/releases/tag/v0.6.5
[v0.7.0]: https://github.com/rrg92/powershai/releases/tag/v0.7.0


<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI
_
<!--PowershaiAiDocBlockEnd-->
