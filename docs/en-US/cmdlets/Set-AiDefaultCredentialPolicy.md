---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Set-AiDefaultCredentialPolicy

## SYNOPSIS <!--!= @#Synop !-->
Defines how Get-AiDefaultCredential will consider bringing the default credential

## DESCRIPTION <!--!= @#Desc !-->
Get-AiDefaultCredential may have conflicting credentials: Multiple credentials available as default. 
If the command cannot safely determine the default, it then uses the Policy defined here to decide what to do.  

The goal is to ensure that the user is fully aware of which credential is being chosen or at least knows that multiple credentials may be available for selection and any of them can be chosen.

For example, when enabling credentials via environment variable, and when there is a credential defined with Set-AiCredential, two default credentials will be possible: the one defined via environment and the one with Set-AiCredential.  
The user may have mistakenly defined a credential via environment variable and forgotten that there was one defined via cmdlet.  
In this scenario, powershai cannot safely determine which credential is valid. So, it uses the policy to determine.

These policies are maintained only in the current session and are not exported, meaning that in scripts, the user must always use this command to define the expected behavior. This is a way for the user to acknowledge (an ack) that they understand and accept the default policy.

## SYNTAX <!--!= @#Syntax !-->

```
Set-AiDefaultCredentialPolicy [[-Policy] <String>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Policy
Defines the policy. Values:
	error 		- throws an error if multiple credentials are defined 
	warning 	- Returns the first credential from the list and issues a warning 
	first 		- Returns the first one without issuing warnings
	script 		- Returns the first resulting from a filter based on a script. The object $_ will point to the AiCredentialSource object (See Get-AiDefaultCredential for details on this object). Specify the script in the following argument.

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI._
<!--PowershaiAiDocBlockEnd-->
