---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Import-PowershaiSettings

## SYNOPSIS <!--!= @#Synop !-->
Importa uma configuração exportada com Export-PowershaiSettings

## DESCRIPTION <!--!= @#Desc !-->
Este cmdlet é o par do Export-PowershaiSettings, e como o nome indica, ele importa os dados que foram exportados.  
Você deve garantir que a mesma senha e o mesmo arquivo são passados.  

IMPORTANTE: Este comando sobrescreverá todos os dados configurados na sessão. Só execute ele se tiver certeza absoluta que nenhum dado configurado previamente pode ser perdido.
Por exemplo, alguma API Token nova gerada recentemente.

Se você estivesse especificado um caminho de exportação diferente do padrão, usando a variável POWERSHAI_EXPORT_DIR, deve usa o mesmo aqui.

O processo de importação valida alguns headers para garantir que o dado foi descriptografado corretamente.  
Se a senha informanda estiver incorreta, os hashs não vão ser iguais, e ele irá disparar o erro de senha incorreta.

Se, por outro lado, um erro de formato inválido de arquivo for exibido, significa que houve alguma corrupção no processo de importação ou é um bug deste comando.  
Neste caso, você pode abrir uma issue no github relatando o problema.

## SYNTAX <!--!= @#Syntax !-->

```
Import-PowershaiSettings [[-ExportDir] <Object>] [<CommonParameters>]
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



<!--PowershaiAiDocBlockStart-->
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
