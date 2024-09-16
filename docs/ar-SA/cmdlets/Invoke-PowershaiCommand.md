---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowershaiCommand

## SYNOPSIS <!--!= @#Synop !-->
يسمح بتشغيل معظم الوظائف بطريقة مختصرة

## DESCRIPTION <!--!= @#Desc !-->
هذا هو أداة بسيطة تسمح بتشغيل العديد من الوظائف بشكل أكثر إيجازًا في سطر الأوامر.  
لاحظ أنه لا يمكن دعم جميع الأوامر بعد.

من الأفضل استخدامه مع الاسم المستعار pshai.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowershaiCommand [[-CommandName] <Object>] [[-RemArgs] <Object>] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
pshai tools # lists the tools
```


## PARAMETERS <!--!= @#Params !-->

### -CommandName
اسم الأوامر

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

### -RemArgs

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
_ترجم تلقائيًا باستخدام PowershAI و AI 
_
<!--PowershaiAiDocBlockEnd-->
