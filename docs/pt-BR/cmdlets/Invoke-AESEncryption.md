---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AESEncryption

## SYNOPSIS <!--!= @#Synop !-->

Invoke-AESEncryption -Mode <string> -Key <string> -Text <string> [<CommonParameters>]

Invoke-AESEncryption -Mode <string> -Key <string> -Path <string> [<CommonParameters>]


## SYNTAX <!--!= @#Syntax !-->

### CryptFile
```
Invoke-AESEncryption -Mode {Encrypt | Decrypt} -Key <string> -Path <string> [<CommonParameters>]
```

### CryptText
```
Invoke-AESEncryption -Mode {Encrypt | Decrypt} -Key <string> -Text <string> [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Key

```yml
Parameter Set: (All)
Type: string
Aliases: 
Accepted Values: 
Required: true
Position: Named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: 
```

### -Mode

```yml
Parameter Set: (All)
Type: string
Aliases: 
Accepted Values: 
Required: true
Position: Named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: 
```

### -Path

```yml
Parameter Set: CryptFile
Type: string
Aliases: 
Accepted Values: 
Required: true
Position: Named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: 
```

### -Text

```yml
Parameter Set: CryptText
Type: string
Aliases: 
Accepted Values: 
Required: true
Position: Named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: 
```