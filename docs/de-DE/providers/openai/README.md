# Provider OpenAI  

# ZUSAMMENFASSUNG <!--! @#Short --> 

Dies ist die offizielle Dokumentation des OpenAI-Providers von PowershAI.

# DETAILS  <!--! @#Long --> 

Der OpenAI-Provider stellt alle Befehle zur Kommunikation mit den Diensten von OpenAI bereit.  
Die Cmdlets dieses Providers haben das Format Verb-OpenaiName.  
Der Provider implementiert die HTTP-Aufrufe gemäß der Dokumentation unter https://platform.openai.com/docs/api-reference

**Hinweis**: Nicht alle Funktionen der API sind derzeit implementiert.


## Erste Schritte 

Die Verwendung des OpenAI-Providers umfasst im Wesentlichen die Aktivierung und Konfiguration des Tokens.  
Sie müssen einen API-Token auf der OpenAI-Website generieren. Das heißt, Sie müssen ein Konto erstellen und Guthaben einfügen.  
Weitere Informationen finden Sie unter https://platform.openai.com/api-keys 

Sobald Sie diese Informationen haben, können Sie den folgenden Code ausführen, um den Provider zu aktivieren:

```powershell 
Set-AiProvider openai 

Set-OpenaiToken
```

Wenn Sie im Hintergrund (ohne Interaktion) ausführen, kann das Token mithilfe der Umgebungsvariablen `OPENAI_API_KEY` konfiguriert werden.  

Mit dem konfigurierten Token können Sie den Chat von Powershai aufrufen:

```
ia "Hallo, ich spreche mit dir aus Powershai"
```

Und natürlich können Sie die Befehle direkt aufrufen:

```
Get-OpenaiChat -prompt "s: Du bist ein Bot, der Fragen zu Powershell beantwortet","Wie zeige ich die aktuelle Uhrzeit an?"
```




* Verwenden Sie Set-AiProvider openai (ist der Standard)
Optional kann eine alternative URL übergeben werden

* Verwenden Sie Set-OpenaiToken, um das Token zu konfigurieren!


## Interne Funktionsweise

OpenAI ist ein wichtiger Provider, da er neben der Bereitstellung zahlreicher fortschrittlicher und robuster KI-Dienste auch als Standardisierungsleitfaden für PowershAI dient.  
Die meisten in PowershAI definierten Standards entsprechen den Spezifikationen von OpenAI, dem am häufigsten verwendeten Provider. Es ist gängige Praxis, OpenAI als Grundlage zu verwenden.  


Und da andere Provider dazu neigen, OpenAI zu folgen, ist dieser Provider auch auf Code-Wiederverwendung vorbereitet.  
Das Erstellen eines neuen Providers, der die gleichen Spezifikationen wie OpenAI verwendet, ist sehr einfach. Sie müssen lediglich einige Konfigurationsvariablen definieren!






<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
