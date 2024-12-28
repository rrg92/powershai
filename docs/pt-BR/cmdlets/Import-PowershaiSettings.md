---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Import-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Importa uma configuração exportada com Export-PowershaiSettings

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet é o pair do Export-PowershaiSettings, e como o nome indica, ele importa os dados que foram exportados.  
Você deve garantir que a mesma senha e o mesmo arquivo são passados.  

IMPORTANTE: Este comando sobscreverá todos os dados configurados na sessão. Só execute ele se tiver certeza absoluta que nenhum dado configurado previamente pode ser perdido.
Por exemplo, alguma API Token nova gerada recentemente.

Se você estivesse especifciado um caminho de export diferente do padrão, usando a variável POWERSHAI_EXPORT_DIR, deve usa ro mesmo aqui.

O processo de import valida alguns headers para garantir que o dado foi descriptografado corretamente.  
Se a senha informanda estiver incorreta, os hashs não vão ser iguais, e ele irá disparar o erro de senha incorreta.

Se, por outro lado, um erro de formado invalido de arquivo for exibido, significa que houve alguma corrupção no proesso de import ou é um bug deste comando.  
Neste caso, você pode abrir uma issue no github relatando o problema.

A partir da versão 0.7.0, um novo arquivo será gerado, chamado exportsession-v2.xml.  
O arquivo antigo será mantido para que o usuário pode recuperar eventuais credenciais, se necessário.

## SYNTAX <!--!= @#Syntax !-->

```
Import-PowershaiSettings [[-ExportDir] <Object>] [-v1] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### Import padrão
```powershell
Import-PowershaiSettings
```

### Importando do OneDrive
```powershell
$Env:POWERSHAI_EXPORT_DIR = "C:\Users\MyUserName\OneDrive\Powershai"
Import-PowershaiSettings
```
Importa as configurações que foram exportadas para um diretório alternativo (one drive).

## PARAMETERS <!--!= @#Params !-->

### -ExportDir

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: $Env:POWERSHAI_EXPORT_DIR
Accept pipeline input: false
Accept wildcard characters: false
```

### -v1
Força a importação da versão 1

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