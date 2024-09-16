# Anbieter Hugging Face

Hugging Face ist das größte Repository für KI-Modelle der Welt!  
Dort haben Sie Zugriff auf eine unglaubliche Auswahl an Modellen, Datensätzen, Demos mit Gradio und vielem mehr!  

Es ist das GitHub der künstlichen Intelligenz, sowohl kommerziell als auch Open Source! 

Der Hugging Face Provider von PowershAI verbindet Ihr Powershell mit einer unglaublichen Auswahl an Diensten und Modellen.  

## Gradio

Gradio ist ein Framework zum Erstellen von Demos für KI-Modelle. Mit wenig Python-Code können Sie Interfaces erstellen, die verschiedene Eingaben akzeptieren, wie z. B. Text, Dateien usw.  
Außerdem verwaltet es viele Aspekte wie Warteschlangen, Uploads usw. Und als Krönung kann es neben der Benutzeroberfläche auch eine API bereitstellen, so dass die über die UI verfügbare Funktionalität auch über Programmiersprachen zugänglich ist.  
PowershAI profitiert davon und stellt die Gradio-APIs auf eine einfachere Weise zur Verfügung, so dass Sie eine Funktionalität von Ihrem Terminal aus aufrufen können und praktisch die gleiche Erfahrung haben!


## Hugging Face Hub  

Der Hugging Face Hub ist die Plattform, auf die Sie unter https://huggingface.co zugreifen können.  
Er ist in Modelle (models) organisiert, die im Grunde genommen der Quellcode der KI-Modelle sind, die andere Personen und Unternehmen auf der ganzen Welt erstellen.  
Es gibt auch "Spaces", in denen Sie Code hochladen können, um Anwendungen zu veröffentlichen, die in Python geschrieben sind (z. B. mit Gradio) oder Docker.  

Erfahren Sie mehr über Hugging Face [in diesem Blogbeitrag von Ia Talking](https://iatalk.ing/hugging-face/)
Und lernen Sie den Hugging Face Hub [in der offiziellen Dokumentation](https://huggingface.co/docs/hub/en/index) kennen.

Mit PowershaAI können Sie Modelle auflisten und sogar mit der API von verschiedenen Spaces interagieren, indem Sie die unterschiedlichsten KI-Anwendungen von Ihrem Terminal aus ausführen.  


# Grundlegende Verwendung

Der Hugging Face Provider von PowershAI verfügt über viele Cmdlets zur Interaktion.  
Er ist in folgenden Befehlen organisiert:

* Befehle, die mit Hugging Face interagieren, haben `HuggingFace` oder `Hf` im Namen. Beispiel: `Get-HuggingFaceSpace` (Alias `Get-HfSpace`).  
* Befehle, die mit Gradio interagieren, unabhängig davon, ob es sich um einen Space von Hugging Face handelt oder nicht, haben `Gradio` oder `GradioSession'  im Namen: `Send-GradioApi`, `Update-GradioSessionApiResult`
* Sie können diesen Befehl verwenden, um die vollständige Liste zu erhalten: `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

Sie müssen sich nicht authentifizieren, um auf die öffentlichen Ressourcen von Hugging Face zuzugreifen.  
Es gibt eine Unmenge an Modellen und Spaces, die kostenlos verfügbar sind, ohne dass eine Authentifizierung erforderlich ist.  
Beispielsweise listet der folgende Befehl die Top 5 am häufigsten heruntergeladenen Modelle von Meta (Autor: meta-llama) auf:

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

Das Cmdlet Invoke-HuggingFaceHub ist dafür verantwortlich, Endpunkte der API des Hubs aufzurufen.  Die Parameter sind die gleichen wie in der Dokumentation unter https://huggingface.co/docs/hub/en/api beschrieben.
Sie benötigen jedoch einen Token, wenn Sie auf private Ressourcen zugreifen möchten: `Set-HuggingFaceToken` (oder `Set-HfToken`) ist das Cmdlet, um den Standardtoken einzufügen, der in allen Anfragen verwendet wird.  



# Struktur der Befehle des Hugging Face Providers  
 
Der Hugging Face Provider ist in drei Hauptgruppen von Befehlen organisiert: Gradio, Gradio Session und Hugging Face.  


## Befehle Gradio*`

Die Cmdlets der Gruppe "gradio" haben die Struktur Verb-GradioName.  Diese Befehle implementieren den Zugriff auf die API von Gradio.  
Diese Befehle sind im Grunde genommen Wrapper für die APIs. Ihre Konstruktion basiert auf dieser Dokumentation: https://www.gradio.app/guides/querying-gradio-apps-with-curl  und auch auf der Beobachtung des Quellcodes von Gradio (z. B. [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py) )
Diese Befehle können mit jeder Gradio-App verwendet werden, unabhängig davon, wo sie gehostet werden: auf Ihrer lokalen Maschine, in einem Space von Hugging Face, auf einem Server in der Cloud... 
Sie benötigen lediglich die Haupt-URL der Anwendung.  


Betrachten Sie diese Gradio-App:

```python 
# file, simple-app.py
import gradio as gr
import time

def Op1(Duration):
    yield f"Dur:{Duration}"
    
    print("Looping...");
    start = time.perf_counter()
    while True:
        now = time.perf_counter();
        
        elapsed = now - start;
        
        if elapsed >= int(Duration) :
            break;
            
        yield elapsed;
        time.sleep(1);
    
    yield f"Finished"
    
    
with gr.Blocks() as demo:
    DurationSeconds = gr.Text(label="Duration, in, seconds", value=5);
    txtResults = gr.Text(label="Resultado");
    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [DurationSeconds], [txtResults] );
    
if __name__ == "__main__":
    demo.launch(show_api=True)
```

Im Grunde genommen zeigt diese App zwei Textfelder an, wobei das eine Feld dazu dient, dass der Benutzer einen Text eingibt, und das andere Feld zur Anzeige der Ausgabe verwendet wird.  
Ein Button, der beim Klicken die Funktion Op1 auslöst. Die Funktion führt eine Schleife für eine bestimmte Anzahl von Sekunden aus, die im Parameter angegeben ist.  
Sie gibt jede Sekunde an, wie viel Zeit vergangen ist.  

Angenommen, diese App ist beim Start unter http://127.0.0.1:7860 erreichbar.
Mit diesem Provider ist die Verbindung zu dieser App einfach:

```powershell
# Installieren Sie powershai, falls es noch nicht installiert ist!
Install-Module powershai 

# Importieren
import-module powershai 

# Überprüfen Sie die Endpunkte der API!
Get-GradioInfo http://127.0.0.1:7860
```

Das Cmdlet `Get-GradioInfo` ist das einfachste. Es liest lediglich den Endpunkt /info, den jede Gradio-App besitzt.  
Dieser Endpunkt gibt wertvolle Informationen zurück, z. B. die verfügbaren API-Endpunkte:

```powershell
# Überprüfen Sie die Endpunkte der API!
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# Listet die Parameter des Endpunkts auf
$AppInfo.named_endpoints.'/op1'.parameters
```

Sie können die API mit dem Cmdlet `Send-GradioApi` aufrufen.  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

Beachten Sie, dass wir die URL, den Namen des Endpunkts ohne Schrägstrich und das Array mit der Liste der Parameter übergeben müssen.
Das Ergebnis dieser Anfrage ist ein Ereignis, das verwendet werden kann, um das Ergebnis der API abzufragen.
Um die Ergebnisse zu erhalten, müssen Sie `Update-GradioApiResult' verwenden.

```powershell
$Event | Update-GradioApiResult
```

Das Cmdlet `Update-GradioApiResult` schreibt die von der API generierten Ereignisse in die Pipeline.  
Es wird ein Objekt für jedes von dem Server generierte Ereignis zurückgegeben. Die Eigenschaft `data` dieses Objekts enthält die zurückgegebenen Daten, falls vorhanden.  


Es gibt außerdem den Befehl `Send-GradioFile`, der Uploads ermöglicht.  Er gibt ein Array von FileData-Objekten zurück, die die Datei auf dem Server repräsentieren.  

Beachten Sie, wie primitiv diese Cmdlets sind: Sie müssen alles manuell machen. Endpunkte abrufen, die API aufrufen, die Parameter als Array senden, die Dateien hochladen.  
Obwohl diese Befehle die direkten HTTP-Aufrufe von Gradio abstrahieren, verlangen sie immer noch viel vom Benutzer.  
Aus diesem Grund wurde die Gruppe der Befehle GradioSession entwickelt, die helfen, den Zugriff auf eine Gradio-App noch weiter zu abstrahieren und dem Benutzer das Leben zu erleichtern!


## Befehle GradioSession*  

Die Befehle der Gruppe GradioSession helfen, den Zugriff auf eine Gradio-App noch weiter zu abstrahieren.  
Mit ihnen kommen Sie dem Powershell näher, wenn Sie mit einer Gradio-App interagieren, und entfernen sich weiter von den nativen Aufrufen.  

Wir werden das Beispiel der vorherigen App verwenden, um einige Vergleiche anzustellen:

```powershell
# Erstellt eine neue Session 
New-GradioSession http://127.0.0.1:7860
```

Das Cmdlet `New-GradioSession` erstellt eine neue Sitzung mit Gradio.  Diese neue Sitzung hat eindeutige Elemente wie eine SessionId, eine Liste der hochgeladenen Dateien, Konfigurationen usw.  
Der Befehl gibt das Objekt zurück, das diese Sitzung darstellt, und Sie können alle erstellten Sitzungen mit `Get-GradioSession` abrufen.  
Stellen Sie sich eine GradoSession als eine geöffnete Registerkarte im Browser mit Ihrer geöffneten Gradio-App vor.  

Die GradioSession-Befehle arbeiten standardmäßig in der Standardsitzung. Wenn es nur eine Sitzung gibt, ist dies die Standardsitzung.  
Wenn es mehrere Sitzungen gibt, muss der Benutzer mit dem Befehl `Set-GradioSession` auswählen, welche die Standardsitzung ist.

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

Einer der mächtigsten Befehle ist `New-GradioSessionApiProxyFunction` (oder Alias GradioApiFunction).  
Dieser Befehl verwandelt die Gradio-APIs der Sitzung in Powershell-Funktionen, d. h. Sie können die API so aufrufen, als wäre es eine Powershell-Funktion.  
Kehren wir zu unserem vorherigen Beispiel zurück


```powershell
# Zuerst öffnen wir die Sitzung!
New-GradioSession http://127.0.0.1:7860

# Jetzt erstellen wir die Funktionen!
New-GradioSessionApiProxyFunction
```

Der obige Code erzeugt eine Powershell-Funktion namens Invoke-GradioApiOp1.  
Diese Funktion hat die gleichen Parameter wie der Endpunkt '/op1', und Sie können get-help für weitere Informationen verwenden:  

```powershell
get-help -full Invoke-GradioApiOp1
```

Um sie auszuführen, rufen Sie sie einfach auf:

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

Beachten Sie, wie der Parameter `Duration`, der in der Gradio-App definiert ist, zu einem Powershell-Parameter wurde.  
Im Hintergrund führt Invoke-GradioApiOp1 `Update-GradioApiResult` aus, d. h. die Rückgabe ist das gleiche Objekt!
Aber sehen Sie, wie einfach es war, die Gradio-API aufzurufen und das Ergebnis zu erhalten!

Apps, die Dateien definieren, wie z. B. Musik, Bilder usw., erzeugen Funktionen, die automatisch diese Dateien hochladen.  
Der Benutzer muss nur den lokalen Pfad angeben.  

Eventuell wird es einige Datentypen geben, die bei der Konvertierung nicht unterstützt werden, und wenn Sie auf einen solchen stoßen, öffnen Sie eine Issue (oder senden Sie einen PR), damit wir sie bewerten und implementieren können!



## Befehle HuggingFace* (oder Hf*)  

Die Befehle dieser Gruppe wurden für die Arbeit mit der API von Hugging Face entwickelt.  
Im Grunde genommen kapseln sie die HTTP-Aufrufe an die verschiedenen Endpunkte von Hugging Face.  

Ein Beispiel:

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

Dieser Befehl gibt ein Objekt zurück, das verschiedene Informationen über den Space diffusers-labs des Benutzers rrg92 enthält.  
Da es sich um einen Gradio-Space handelt, können Sie ihn mit den anderen Cmdlets verbinden (die GradioSession-Cmdlets können erkennen, wann ein von Get-HuggingFaceSpace zurückgegebenes Objekt an sie übergeben wird!)

```
# Verbinden mit dem Space (und automatisch eine Gradio-Sitzung erstellen)
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

#Standard
Set-GradioSession -Default $diff

# Funktionen erstellen!
New-GradioSessionApiProxyFunction

# Aufrufen!
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**WICHTIG: Denken Sie daran, dass der Zugriff auf bestimmte Spaces nur mit Authentifizierung möglich ist. In diesen Fällen müssen Sie Set-HuggingFaceToken verwenden und einen Zugriffstoken angeben.**




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
