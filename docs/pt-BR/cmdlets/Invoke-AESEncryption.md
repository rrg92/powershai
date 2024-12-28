---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-AESEncryption

## SYNOPSIS <!--!= @#Synop !-->
CRiptografa/Descruptografa string usando AES

## DESCRIPTION <!--!= @#Desc !-->
Adaptado deste link: https://www.powershellgallery.com/packages/DRTools/4.0.2.3/Content/Functions%5CInvoke-AESEncryption.ps1
Obrigado!

## SYNTAX <!--!= @#Syntax !-->

### CryptFile
```
Invoke-AESEncryption -Mode <String> -Key <String> -Path <String> [<CommonParameters>]
```

### CryptText
```
Invoke-AESEncryption -Mode <String> -Key <String> -Text <String> [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -Mode

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: true
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Key

```yml
Parameter Set: (All)
Type: String
Aliases: 
Accepted Values: 
Required: true
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Text

```yml
Parameter Set: CryptText
Type: String
Aliases: 
Accepted Values: 
Required: true
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -Path

```yml
Parameter Set: CryptFile
Type: String
Aliases: 
Accepted Values: 
Required: true
Position: named
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```