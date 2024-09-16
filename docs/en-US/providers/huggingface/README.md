# Hugging Face Provider

Hugging Face is the world's largest repository of AI models!  
There, you have access to an incredible range of models, datasets, demonstrations with Gradio, and much more!  

It's the GitHub of Artificial Intelligence, both commercial and open source!

The Hugging Face provider for PowershAI connects your powershell with an incredible range of services and models.  

## Gradio

Gradio is a framework for creating demonstrations for AI models. With a little Python code, it is possible to create interfaces that accept various inputs, such as text, files, etc.  
And, besides that, it manages many issues like queues, uploads, etc.  And, to top it off, along with the interface, it can provide an API so that the functionality exposed via UI is also accessible through programming languages.  
PowershAI benefits from this, and exposes Gradio's APIs in an easier way, where it's possible to invoke a functionality from your terminal and have practically the same experience!


## Hugging Face Hub  

The Hugging Face Hub is the platform you access at https://huggingface.co  
It is organized into models, which are basically the source code of the AI models that other people and companies create around the world.  
There are also "Spaces", which is where you can upload code to publish applications written in python (using Gradio, for example) or docker.  

Learn more about Hugging Face [in this Ia Talking blog post](https://iatalk.ing/hugging-face/)
And, get to know the Hugging Face Hub [in the official doc](https://huggingface.co/docs/hub/en/index)

With PowershaAI, you can list models and even interact with the API of several spaces, running the most varied AI apps from your terminal.  


# Basic usage

The Hugging Face provider for PowershAI has many cmdlets for interaction.  
It is organized into the following commands:

* commands that interact with the Hugging Face have `HuggingFace` or `Hf` in their names. Example: `Get-HuggingFaceSpace` (alias `Get-HfSpace`).  
* commands that interact with Gradio, regardless of whether they are a Hugging Face Space or not, have `Gradio` or `GradioSession'  in their names: `Send-GradioApi`, `Update-GradioSessionApiResult`
* You can use this command to get the complete list: `get-command -mo powershai -Noun Hf*,HuggingFace*,Gradio*`

You don't need to authenticate to access public Hugging Face resources.  
There are an endless number of models and spaces available for free without the need for authentication.  
For example, the following command lists the top 5 most downloaded models from Meta (author: meta-llama):

```powershell
import-module powershai
Invoke-HuggingFaceHub "models" -limit 5 -author meta-llama -sort downloads -direction -1 
```

The Invoke-HuggingFaceHub cmdlet is responsible for invoking Hub API endpoints.  The parameters are the same as those documented in https://huggingface.co/docs/hub/en/api
However, you will need a token if you need to access private resources: `Set-HuggingFaceToken` (or `Set-HfToken`)  is the cmdlet to insert the default token used in all requests.  



# Structure of Hugging Face provider commands  
 
The Hugging Face provider is organized into 3 main groups of commands: Gradio, Gradio Session and Hugging Face.  


## Gradio*` Commands

The cmdlets of the "gradio" group have the structure Verb-GradioName.  These commands implement access to the Gradio API.  
These commands are basically wrappers for APIs. Their construction was based on this doc: https://www.gradio.app/guides/querying-gradio-apps-with-curl  and also observing the Gradio source code (ex.: [Routes](https://github.com/gradio-app/gradio/blob/main/gradio/routes.py) )
These commands can be used with any gradio app, regardless of where they are hosted: on your local machine, in a Hugging Face space, on a server in the cloud... 
You just need the main URL of the application.  


Consider this gradio app:

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

Basically, this app displays 2 text fields, one of which is where the user types in text and the other is used to show the output.  
A button, which when clicked, triggers the Op1 function. The function loops for a determined number of seconds informed in the parameter.  
Every second, it returns how much time has passed.  

Suppose that when starting, this app is accessible at http://127.0.0.1:7860.
With this provider, connecting to this app is simple:

```powershell
# install powershai, if not installed!
Install-Module powershai 

# Import
import-module powershai 

# Check the api endpoints!
Get-GradioInfo http://127.0.0.1:7860
```

The `Get-GradioInfo` cmdlet is the simplest. It just reads the /info endpoint that every gradio app has.  
This endpoint returns valuable information, such as the available API endpoints:

```powershell
# Check the api endpoints!
$AppInfo = Get-GradioInfo http://127.0.0.1:7860

# list the parameters of the endpoint
$AppInfo.named_endpoints.'/op1'.parameters
```

You can invoke the API using the `Send-GradioApi` cmdlet.  

```powershell
$Event = Send-GradioApi -AppUrl 'http://127.0.0.1:7860' -ApiName Op1 -Params @(1)
```

Note that we need to pass the URL, the name of the endpoint without the slash, and the array with a list of parameters.
The result of this request is an event that can be used to check the result of the API.
To get the results, you must use `Update-GradioApiResult' 

```powershell
$Event | Update-GradioApiResult
```

The `Update-GradioApiResult` cmdlet will write the events generated by the API to the pipeline.  
An object will be returned for each event generated by the server. The `data` property of this object has the returned data, if any.  


There is also the `Send-GradioFile` command, which allows you to make uploads.  It returns an array of FileData objects, which represent the file on the server.  

Note how primitive these cmdlets are: You have to manually do everything. Get the endpoints, invoke the api, send the parameters as an array, upload the files.  
Although these commands abstract the direct HTTP calls of Gradio, they still require a lot from the user.  
That's why the GradioSession group of commands was created, which helps to abstract even more and make life easier for the user!


## GradioSession* Commands  

The commands in the GradioSession group help to abstract even more the access to a Gradio app.  
With them, you are closer to powershell when interacting with a gradio app and further away from native calls.  

Let's use the same example of the previous app to make some comparisons:

```powershell
# creates a new session 
New-GradioSession http://127.0.0.1:7860
```

The `New-GradioSession` cmdlet creates a new session with Gradio.  This new session has unique elements like a SessionId, a list of uploaded files, configurations, etc.  
The command returns the object that represents this session, and you can get all the created sessions using `Get-GradioSession`.  
Imagine a GradoSession as a browser tab open with your gradio app open.  

GradioSession commands operate, by default, on the default session. If there is only 1 session, it is the default session.  
If there is more than one, the user must choose which is the default using the `Set-GradioSession` command

 ```powershell
$app1 = New-GradioSession http://127.0.0.1:7860
$app2 = New-GradioSession http://127.0.0.1:7861

Set-GradioSession -Default $app2
```

One of the most powerful commands is `New-GradioSessionApiProxyFunction` (or alias GradioApiFunction).  
This command transforms the Gradio APIs of the session into powershell functions, that is, you can invoke the API as if it were a powershell function.  
Let's go back to the previous example


```powershell
# first, opening the session!
New-GradioSession http://127.0.0.1:7860

# Now, let's create the functions!
New-GradioSessionApiProxyFunction
```

The code above will generate a powershell function called Invoke-GradioApiOp1.  
This function has the same parameters as the '/op1' endpoint, and you can use get-help for more information:  

```powershell
get-help -full Invoke-GradioApiOp1
```

To execute, just invoke:

```powershell
Invoke-GradioApiOp1 -Duration 10 | %{ "ElapsedSeconds: $($_.data)" }
```

Note how the `Duration` parameter defined in the gradio app became a powershell parameter.  
Behind the scenes, Invoke-GradioApiOp1 is running `Update-GradioApiResult`, that is, the return is the same object!
But, notice how much simpler it was to invoke the Gradio API and receive the result!

Apps that define files, like music, images, etc., generate functions that automatically upload those files.  
The user just needs to specify the local path.  

Eventually, there may be some other type of data not supported in the conversion, and, if you find it, open an issue (or submit a PR) so we can evaluate and implement it!



## HuggingFace* (or Hf*) Commands  

The commands in this group were created to operate with the Hugging Face API.  
Basically, they encapsulate the HTTP calls to the various Hugging Face endpoints.  

An example:

```
Get-HuggingFaceSpace rrg92/diffusers-labs
```

This command returns an object that contains various information about the diffusers-labs space, from user rrg92.  
As it is a gradio space, you can connect it with the other cmdlets (the GradioSession cmdlets can understand when an object returned by Get-HuggingFaceSpace is passed to them!)

```
# Connect to the space (and, automatically, creates a gradio session)
$diff = Get-HuggingFaceSpace rrg92/diffusers-labs

#Default
Set-GradioSession -Default $diff

# Creates functions!
New-GradioSessionApiProxyFunction

# invoke!
Invoke-GradioApiGenerateimage -Prompt "a car flying"
```

**IMPORTANT: Remember that access to certain spaces can only be done with authentication, in these cases, you must use Set-HuggingFaceToken and specify an access token.;**



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
