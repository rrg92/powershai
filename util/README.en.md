# Utilities

[portuguese](README.md)

This directory contains useful scripts to help with the PowershAI development and documentation process.

# Tips

## How to generate documentation from code (comments)?

Use the Cmdlets2Markdown.ps1 script:

```powershell
. .\util\Cmdlets2Markdown.ps1 -Update
```

This will update all files in the docs/pt-BR/cmdlets directory.
Direct documentation in the code is in pt-BR, as it is faster for me to document in my native language.
But this may change in the future.  For now, we use pt-BR as the source for markdown and other language documentation.

## How to translate files in docs/ to other languages?

The aidoc.ps1 script can help generate an automatic translation.
It uses powershai itself to send the data to the desired provider and update the files.
It keeps controls to avoid sending files that haven't been changed, or trying to overwrite files that have already been changed by someone.

How to use:

- Create the desired language directory in docs/, if it doesn't exist. This tells the script that this language is supported. Use the BCP 47 code (aa-BB format)
- Choose a provider and model that support large amounts of context. Particularly, I have been doing it with Google Gemini Flash 1.5, which has a context of about 1M, low cost and very good results.

Having made these prerequisites, run the script, examples:

```
# Example 
.\util\aidoc.ps1 -SourceLang pt-BR -TargetLang en-US -Provider google -MaxTokens 32000
```

Note that I am using pt-BR as the source.
I always use pt-BR as the source, as it is the language in which I trust the content at the moment.

### Important about documentation translation with AI

Note that this process tends to be automatic, you may not need to worry (but, if you want to learn and study a practical use of powershai, it's a good test).
Just remember that using the provider can incur costs.
The costs of the translations done so far have been paid by the project author, Rodrigo, using his own tokens.
Keep in mind that, when doing tests, you will use your own tokens, and therefore, you will have your own cost (and there is no guarantee that these modifications will be approved).

## How to generate compiled Powershell documentation from docs/

The doc.ps1 script was created to convert documentation in docs/ to compiled Powershell help that can be distributed with the module.
This is a process that I am still testing, and therefore, there is nothing being published.

The doc.ps1 script performs several validations and adjustments to adapt the files in docs/ to the format expected by PlatyPS.
PlatyPs is a module that helps generate documentation in the Powershell MAML format, compiled into .xml

```
.\util\doc.ps1 -WorkDir T:\platy -SupportedLangs ja-JP  -MaxAboutWidth 150
```

`workDir` is a temporary directory where it will copy and modify the files, as well as use as a stage for the process.
`SupportedLangs` is a list of languages you want to generate.
`MaxAboutWidth` controls the maximum size of a line. PlatyPS can generate an error due to a module bug, and increasing the MaxAboutWidth can prevent this error.
``` you want to generate.
`MaxAboutWidth` controls the maximum size of a line. PlatyPS can generate an error due to a module bug, and increasing the MaxAboutWidth can prevent this error.
```
