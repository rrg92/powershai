---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Confirm-PowershaiObjectSchema

## SYNOPSIS <!--!= @#Synop !-->
Validates if an object follows a correct schema

## DESCRIPTION <!--!= @#Desc !-->
This command validates if the structure of an object, or hashtable, follows a schema.  
The schema is defined in the schema parameter, and has the following syntax:

```
@{    
    #Define each expected key in the object!
    Key1 = [string]         # expected data type!
    Key2 = "val1","val2"     # list of expected values
    
    # A key that is an object! Each item must specify the expected object props!
    Key3 = @{
                SubKey1 = [int] # Means: Key3.SubKey1 must be int
            }
            
    # A key that is an array!
    Key4 = @{
            '$schema' = "array" # the special key $schema is a metadata that defines the schema!
            
            SubKey1 = [string] # Then, each subkey is treated as
        }
}
```

'$schema' must follow the same specifications as OpenAPI.
If $schema is a type, it's the same as specifying $schema.type = "array".

## SYNTAX <!--!= @#Syntax !-->

```
Confirm-PowershaiObjectSchema [[-obj] <Object>] [[-schema] <Object>] [[-parent] <Object>] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -obj

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

### -schema

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

### -parent

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



<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
