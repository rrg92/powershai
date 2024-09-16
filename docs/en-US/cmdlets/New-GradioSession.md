---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# New-GradioSession

## SYNOPSIS <!--!= @#Synop !-->
Creates a new Gradio session.

## DESCRIPTION <!--!= @#Desc !-->
A Session represents a connection to a Gradio app.  
Think of a session as a browser tab open and connected to a particular Gradio app.  
Uploaded files, calls made, logins are all recorded in this session.

This cmdlet returns an object that we call "GradioSession".  
This object can be used in other cmdlets that depend on session (and a default active session can be set that all cmdlets use by default if not specified).  

Every session has a name that uniquely identifies it. If not provided by the user, it will be automatically created based on the app's URL.  
There cannot be 2 sessions with the same name.

When creating a session, this cmdlet saves this session in an internal session repository.

## SYNTAX <!--!= @#Syntax !-->

```
New-GradioSession [[-AppUrl] <Object>] [[-Name] <Object>] [[-DownloadPath] <Object>] [-Force] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl
Url of the app

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

### -Name
Unique name that identifies this session!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -DownloadPath
Directory where to download files

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Force
Force recreate

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




<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI_
<!--PowershaiAiDocBlockEnd-->
