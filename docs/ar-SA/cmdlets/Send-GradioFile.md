---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Send-GradioFile

## SYNOPSIS <!--!= @#Synop !-->
يرفع ملفًا واحدًا أو أكثر.
يرجع كائنًا بنفس التنسيق مثل gradio FileData (https://www.gradio.app/docs/gradio/filedata).
إذا كنت ترغب في إرجاع مسار الملف فقط على الخادم، فاستخدم المعلمة -Raw.
شكرًا لـ https://www.freddyboulton.com/blog/gradio-curl و https://www.gradio.app/guides/querying-gradio-apps-with-curl

## SYNTAX <!--!= @#Syntax !-->

```
Send-GradioFile [[-AppUrl] <Object>] [[-Files] <Object>] [-Raw] [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->

### -AppUrl

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

### -Files
قائمة الملفات (المسارات أو FileInfo)

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

### -Raw
يرجع النتيجة مباشرة من الخادم!

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
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
