---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Enter-AiCredential

## SYNOPSIS <!--!= @#Synop !-->
Runs a code and always provides a specific credential

## DESCRIPTION <!--!= @#Desc !-->
This command allows you to run a code that will always use a specific credential.
Whenever the Get-AiDefaultCredential function is invoked, the informed credential will always be returned.

## SYNTAX <!--!= @#Syntax !-->

```
Enter-AiCredential [[-credential] <Object>] [[-code] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -credential

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

### -code

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


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
