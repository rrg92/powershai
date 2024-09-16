---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Get-AiModels

## SYNOPSIS <!--!= @#Synop !-->
listet die verfügbaren Modelle im aktuellen Provider

## DESCRIPTION <!--!= @#Desc !-->
Dieser Befehl listet alle LLMs auf, die mit dem aktuellen Provider verwendet werden können, um sie in PowershaiChat zu verwenden.
Diese Funktion hängt davon ab, dass der Provider die Funktion GetModels implementiert.

Das zurückgegebene Objekt variiert je nach Provider, aber jeder Provider muss ein Array von Objekten zurückgeben, von denen jedes mindestens die Eigenschaft id enthalten muss, die eine Zeichenkette sein muss, die verwendet wird, um das Modell in anderen Befehlen zu identifizieren, die von einem Modell abhängen.

## SYNTAX <!--!= @#Syntax !-->

```
Get-AiModels [<CommonParameters>]
```

## PARAMETERS <!--!= @#Params !-->




<!--PowershaiAiDocBlockStart-->
_Automatisch übersetzt mit PowershAI und KI 
_
<!--PowershaiAiDocBlockEnd-->
