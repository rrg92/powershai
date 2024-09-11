# Provider Hugging Face

Hugging Face is the largest AI model repository in the world!  
There, you have access to an incredible range of models, datasets, demonstrations with Gradio, and much more!  

It's the GitHub of Artificial Intelligence, both commercial and open source! 

The Hugging Face provider of PowershAI connects your PowerShell with an amazing range of services and models.  

## Gradio

Gradio is a framework for creating demonstrations for AI models. With just a little Python code, you can deploy interfaces that accept various inputs, such as text, files, etc.  
Moreover, it manages many issues like queues, uploads, etc. And, to top it off, along with the interface, it can provide an API so that the functionality exposed via UI is also accessible through programming languages.  
PowershAI benefits from this and exposes the Gradio APIs in an easier way, where you can invoke a functionality from your terminal and have practically the same experience!


## Hugging Face Hub  

The Hugging Face Hub is the platform you access at https://huggingface.co  
It is organized into models (models), which are basically the source code of AI models that other people and companies create around the world.  
There are also "Spaces," where you can upload code to publish applications written in Python (using Gradio, for example) or Docker.  

Learn more about Hugging Face [in this Ia Talking blog post](https://iatalk.ing/hugging-face/)
And, check out the Hugging Face Hub [in the official documentation](https://huggingface.co/docs/hub/en/index)

With PowershAI, you can list models and even interact with the API of various spaces, running a variety of AI apps from your terminal.  


# Basic Usage

The Hugging Face provider of PowershAI has many cmdlets for interaction.  
It is organized into the following commands:

* commands that interact with Hugging Face have `HuggingFace` or `Hf` in the name. Example: `Get-HuggingFaceSpace` (alias `Get-HfSpace`).  
* commands that interact with Gradio, regardless of whether they are a Hugging Face Space or not, have `Gradio` or `GradioSession` in the name: `Send-GradioApi`, `Update-GradioSessionApiResult`
* You can use this command to get the complete list: `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

You do not need to authenticate to access public resources of Hugging Face.  
There are countless models and spaces available for free without the need for authentication.  
For example, the following command lists the top 5 most downloaded models from Meta (author: meta-llama):

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

The cmdlet Invoke-HuggingFaceHub is responsible for invoking API endpoints of the Hub. The parameters are the same as documented at https://huggingface.co/docs/hub/en/api
However, you will need a token if you need to access private resources: `Set-HuggingFaceToken` (or `Set-HfToken`) is the cmdlet to insert the default token used in all requests.  



# Command Structure of the Hugging Face Provider  
 
The Hugging Face provider is organized into 3 main groups of commands: Gradio, Gradio Session, and Hugging Face.  


## Gradio* Commands

The cmdlets in the "gradio" group have the structure Verb-GradioName. These commands implement access to the Gradio API.  
These commands are basically wrappers for the APIs. Their construction was based on this doc: https://www.gradio.app/guides/querying-gradio-apps-with-curl and also by observing the source code of Gradio (e.g., [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py))
These commands can be used with any Gradio app, regardless of where they are hosted: on your local machine, in a Hugging Face space, on a cloud server... 
You just need the main URL of the application.  


Consider this Gradio app:

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
    txtResults = gr.Text(label="Result");
    btnOp1 = gr.Button(value="Op1");
    btnOp1.click( Op1, [DurationSeconds], [txtResults] );
    
if __name__ == "__main__":
    demo.launch(show_api=True)
```

Basically, this app displays 2 text fields, one of which is where the user types text and the other is used to show the output.  
A button, which when clicked, triggers the Op1 function. The function loops for a specified number of seconds provided in the parameter.  
Every second, it yields how much time has passed.  

Suppose that when started, this app is accessible at http://127.0.0.1:7860.
With this provider, connecting to this app is simple:

```powershell
# install powershai, if not installed!
Install-Module powershai 

# Import
import-module powershai 

# Check the API endpoints!
Get-GradioInfo http://127.0.0.1:7860
```

The cmdlet `Get-GradioInfo` is the simplest. It simply reads the /info endpoint that every Gradio app has.  
This endpoint returns valuable information, such as the available API endpoints:

```powershell
# Check the API endpoints!
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# list the parameters of the endpoint
$AppInfo.named_endpoints.'/op1'.parameters
```

You can invoke the API using the `Send-GradioApi` cmdlet.  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

Note that we need to pass the URL, the name of the endpoint without the slash, and the array with the list of parameters.
The result of this request is an event that can be used to query the result of the API.
To obtain the results, you should use `Update-GradioApiResult` 

```powershell
$Event | Update-GradioApiResult
```

The cmdlet `Update-GradioApiResult` will write the events generated by the API to the pipeline.  
An object will be returned for each event generated by the server. The `data` property of this object contains the returned data, if any.  


There is also the command `Send-GradioFile`, which allows uploads. It returns an array of FileData objects that represent the file on the server.  

Note how these cmdlets are quite primitive: You must manually do everything. Get the endpoints, invoke the API, send the parameters as an array, upload the files.  
Although these commands abstract the direct HTTP calls from Gradio, they still require a lot from the user.  
That's why the GradioSession command group was created, which helps to further abstract and make the user's life easier!


## GradioSession* Commands  

The commands in the GradioSession group help to further abstract access to a Gradio app.  
With them, you get closer to PowerShell when interacting with a Gradio app and further away from native calls.  

Let's use the previous app example to make some comparisons:

```powershell```powershell
# creates a new session 
New-GradioSession http://127.0.0.1:7860
```

The cmdlet `New-GradioSession` creates a new session with Gradio. This new session has unique elements such as a SessionId, list of uploaded files, settings, etc.  
The command returns the object that represents this session, and you can retrieve all created sessions using `Get-GradioSession`.  
Think of a GradioSession like a tab in a browser opened with your Gradio app.

GradioSession commands operate, by default, on the default session. If there is only 1 session, it is the default session.  
If there are multiple sessions, the user must choose which is the default using the command `Set-GradioSession`.

```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

One of the most powerful commands is `New-GradioSessionApiProxyFunction` (or alias GradioApiFunction).  
This command transforms the Gradio APIs of the session into PowerShell functions, meaning you can invoke the API as if it were a PowerShell function.  
Let’s return to the previous example.

```powershell
# first, opening the session!
New-GradioSession http://127.0.0.1:7860

# Now, let's create the functions!
New-GradioSessionApiProxyFunction
```

The code above will generate a PowerShell function called Invoke-GradioApiOp1.  
This function has the same parameters as the endpoint '/op1', and you can use get-help for more information:

```powershell
get-help -full Invoke-GradioApiOp1
```

To execute, just invoke:

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

Note how the parameter `Duration` defined in the Gradio app became a PowerShell parameter.  
Under the hood, Invoke-GradioApiOp1 is executing `Update-GradioApiResult`, meaning the return is the same object!  
But, notice how much simpler it was to invoke the Gradio API and receive the result!

Apps that define files, such as music, images, etc., generate functions that automatically upload those files.  
The user just needs to specify the local path.

Eventually, there may be some unsupported data type in the conversion, and if you encounter it, please open an issue (or submit a PR) for us to evaluate and implement!

## HuggingFace* Commands (or Hf*)

The commands in this group were created to operate with the Hugging Face API.  
Basically, they encapsulate HTTP calls to the various endpoints of Hugging Face.

An example:

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

This command returns an object that contains various information about the diffusers-labs space from user rrg92.  
Since it's a Gradio space, you can connect it with the other cmdlets (the GradioSession cmdlets can understand when an object returned by Get-HuggingFaceSpace is passed to them!)

```
# Connect to the space (and automatically creates a Gradio session)
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

#Default
Set-GradioSession -Default $diff

# Creates functions!
New-GradioSessionApiProxyFunction

# invokes!
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**IMPORTANT: Remember that access to certain spaces may require authentication; in these cases, you should use Set-HuggingFaceToken and specify an access token.**


_Automatically translated using PowershAI and AI._
