# Contributing to PowershAI

Thank you very much for your interest in contributing to PowershAI!
One of the main goals of this project is to build it from the experience of several people, making it more stable, robust, and unique!

This guide will help you with everything you need to configure and follow our standards so you can modify the project and submit the changes.


# Prerequisites

PowershAI is a relatively simple PowerShell module: you only need a computer with PowerShell and a text editor to modify it.
On Windows, I really like using Notepad++, but you can use any editor you prefer, such as Visual Studio Code.

Furthermore, the tools you will need are for interaction with Git and some other PowerShell modules to run tests and/or generate documentation.

Here is a summary list of the software you need:

- A text editor of your choice
- PowerShell installed, can be Windows or Linux.
- Git, obviously, to clone the repository and push
- Pester module, if you want to run tests. Install with `Install-Module Pester` (you only need to do this once)
- PlatyPS module, if you want to generate documentation. Install with `Install-Module PlatyPs` (you only need to do this once)


Once you have everything you need, clone this repository to a directory of your choice.
For the examples in this article, I will assume you cloned it to `C:\temp\powershai`, but you can choose any directory you prefer.

Before you start modifying PowershAI, it is very important that you understand its operation and basic commands.
I recommend that you see the [examples](examples/) section and try using PowershAI so you can modify it.

Basically, you need to be familiar with PowerShell syntax, understand the concepts introduced by PowershAI, such as providers, and, obviously, a basic understanding of LLMs, APIs, and HTTP REST.


# Development Workflow

Adding or changing something in PowershAI is a relatively simple process.
The basic flow is this:

* Create an issue describing the problem, if one doesn't exist
* Clone the PowershAI repository to a directory of your choice
* Make the necessary modifications and test (this includes code and documentation modifications, including automatic translation)
* Run the test scripts in your environment and make sure all tests pass
* Create a PR and submit it, detailing as much as possible, always clearly. Keep communication in English or Brazilian Portuguese.
* Add to the CHANGELOG, in the unreleased section
* A maintainer will review your modifications and approve or reject them.
* Once approved, it will be merged into the next version's branch, which will be controlled by a maintainer

Knowing the file and directory structure is essential to determining what you will change. See below.

# File and Directory Structure

When you clone the project, you will see several directories and files, briefly explained below:

|Item				| Description													|
|-------------------|---------------------------------------------------------------|
|docs				| Contains the PowershAI documentation							|
|powershai 			| Contains the PowershAI source code							|
|tests 				| Contains the PowershAI test scripts 							|
|util 				| Contains auxiliary development scripts						|


## powershai

The [powershai] directory is the module itself, that is, the PowershAI source code.
Like any PowerShell module, it contains a .psm1 file and a .psd1 file.
The [powershai.psm1] file is the root of the module, that is, it is the file that is executed when you run `Import-Module powershai`.
The [powershai.psd1] file is the module manifest, which contains important metadata about the module, such as version, dependencies, and copyright.

The other files are loaded by [powershai.psm1], automatically or as certain commands are executed.
Initially, all the PowershAI source code was in the [powershai.psm1] file, but as it grows, it becomes better for development to separate it into smaller files, grouped by functionality. As new versions are released, new structures and files may emerge for better organization.

Here is a brief summary of the most important files and/or directories:

- [lib](/powershai/lib)
Contains several auxiliary scripts with generic functions and utilities that will be used by other PowershAI components.

- [chats.ps1](/powershai/chats.ps1)
Contains all the cmdlets and functions that implement the PowershAI Chats feature

- [AiCredentials.ps1](/powershai/AiCredentials.ps1)
Contains all the cmdlets and functions that implement the AiCredential feature

- [providers](/powershai/providers)
Contains 1 file for each provider, with the provider's name.
PowershAI.psm1 will load these files when imported.
For more information on how to develop providers, see [the provider development documentation](providers/DEVELOPMENT.about.md)


This is a summary of the basic flow of what happens when you import the PowershAI module:

- The `powershai.psm1` file defines a series of functions and variables
- It loads functions defined in the libs
- Finally, the providers in [providers](/powershai/providers) are loaded


The quickest way to find out where the command you want to change is defined is to do a simple search using PowerShell commands (or using Git search).
Some examples:

```powershell
# Where is the Get-Aichat function?
gci -rec powershai | sls 'function Get-AiChat' -SimpleMatch

# Where is a function with 'Encryption' in the name?
gci -rec powershai | sls 'function.+Encryption'

#Tip: sls is an alias for Select-String, a native PowerShell command that searches within the file using RegEx or simple match. Similar to Linux's Grep.
```

Once you have determined the file, you can open it in your preferred editor and start adjusting it.
Remember to test and configure the credentials for the providers if you need to invoke a command that will interact with an LLM that requires authentication.

### Importing the module under development

Normally, you import the module with the command `Import-Module powershai`.
This command searches for the module in the standard PowerShell module path.
During development, you should import from the path where you cloned:

```
cd C:\temp\
git clone https://github.com/rrg92/powershai
cd powershai
Import-Module -force ./powershai
```

Note that the command specifies `./powershai`. This causes PowerShell to look for the module in the `powershai` directory of the current directory.
This ensures that you are importing the module from the currently cloned directory, and not the module installed in one of the standard module directories.

> [!NOTE]
> Whenever you make a change to the PowershAI source code, you must import the module again.


## tests

The `tests` directory contains everything needed to test PowershAI.
The basis of the tests is done with the Pester module, which is a PowerShell module that facilitates the creation and execution of tests.

The files with the test definitions are in the [tests/pester](/tests/pester) directory.
A script called [tests/test.ps1](/tests/test.ps1) allows you to easily invoke Pester and handles some filters so you can skip specific tests while developing.

### Running tests

The easiest way to start the PowershAI tests is by invoking the script:

```
tests/test.ps1
```

Without any parameters, this script will invoke a series of tests considered "basic".
To run all tests, pass the value "production" in the first argument:

```
tests/test.ps1 production
```

This is the option used when performing the final test for a new version of PowershAI.
If you have Docker installed, you can use `docker compose up --build` to start the same production test suite that will be done on Git.
By default, a PowerShell Core image on Linux is used. The `docker-compose.yml` and `Dockerfile` files in the root of the repository contain all the options used.

Passing the production test is one of the prerequisites for your modifications to be accepted. Therefore, before submitting your PR, run the local tests to ensure everything is working as expected.


### Defining tests

You should also define and adjust the tests for the modifications you make.
One of the goals we have for PowershAI is that all commands have a unit test defined, in addition to tests that validate more complex features.
Since PowershAI started without tests, it is likely that there are still many commands without tests.
However, as these commands are modified, or new ones are added, it is mandatory that the tests are defined and adjusted.

To create a test, you should use the [Pester module 5 syntax](https://pester.dev/docs/quick-start).
The directory where the test script will look is `tests/pester`, so you should put the files there.
Only files with the `.tests.ps1` extension will be loaded.



## docs

The `docs` directory contains all the PowershAI documentation. Each subdirectory is specific to a language and should be identified by the BCP 47 code (aa-BB format).
You can create Markdown files directly in the desired language directory and start editing in that language.

Some included files will only be accessible in this Git repository, but some will be used to assemble documentation accessible via the PowerShell `Get-Help` command.
The PowershAI publication process will generate the necessary files with all the documentation, according to languages. Thus, the user will be able to use the `Get-Help` command, which will determine the correct documentation according to the language and location of the machine where PowershAI is running.

For this to work correctly, the `docs/` directory has a minimum organization that must be followed so that the automatic process works and, at the same time, it is possible to have minimum documentation accessible directly here through the Git repository.

### `docs` Directory Rules
The `docs` directory has some simple rules to better organize and allow the creation of PowerShell help files:

#### Use .md (Markdown) or .about.md extension
You should create the documentation using Markdown files (`.md` extension).
Files with the `.about.md` extension will be converted into a PowerShell help topic. For example, the `CHATS.about.md` file will become the `powershai_CHATS` help topic.
Each subdirectory in which a `.about.md` file is found, the directory name is prefixed to the help topic. `README.md` is considered the help topic of the directory itself.
For example, a file in `docs/en-US/providers/openai/README.md` will become the `powershai_providers_openai` help topic.
The `docs/en-US/providers/openai/INTERNALS.about.md` file will become the `powershai_providers_openai_internals` help topic.

#### `docs/lang/cmdlets` Directory
This directory contains a Markdown file for each cmdlet that needs to be documented.
The content of these files must follow the format accepted by PlatyPS.
You can use the auxiliary script `util\Cmdlets2Markdown.ps1` to generate the Markdown files from the documentation done via comments.

#### `docs/lang/providers` Directory
Contains a subdirectory for each provider, and within this subdirectory all the documentation pertinent to the provider should be documented.
Documentation about providers that is not specific to a provider should be in the root `docs/lang/providers`.

#### `docs/lang/examples` Directory
This directory contains examples of using PowershAI.
The file names should follow the pattern `NNNN.md`, where NNNN is a number from 0000 to 9999, always with leading zeros.

### Translation

The translation of the documentation can be done in two ways: manually or with AI using PowershAI itself.
To translate with PowershAI, you can use the `util\aidoc.ps1` script. This script was created to allow the documentation of PowershAI to be quickly made available in other languages.

#### Manual Translation

Manual translation is very simple: copy the file from the language you want to translate from to the same path in the directory of the language you will translate to.
Then edit the file, make the revisions, and commit.

Manually translated files will not be translated by the automatic process described below.

#### Automatic Translation
The automatic translation process is as follows:
- You write the documentation in the original language, generating the Markdown file according to the rules above.
- Import the PowershAI module into the session and make sure the credentials are configured correctly.
- You use the `util\aidoc.ps1` script, passing the source language you are writing in and the desired target language. I recommend using Google Gemini.
- The script will generate the files. You can review them. If everything is okay, then do a Git commit. If not, remove the unwanted files or use `git restore` or `git clean`.


The `AiDoc.ps1` script maintains a control file in each directory called `AiTranslations.json`. This file is used to control which files have been automatically translated into each language, and with it, `AiDoc.ps1` can determine when a source file has been changed, avoiding translations of files that have not been changed.

Also, if you manually edit one of the files in the destination directory, that file will no longer be automatically translated to avoid overwriting a review you have made. Therefore, if you change the files, however minimal the change, this may prevent automatic translation from occurring. If you want the translation to be done anyway, delete the destination file or use the `-Force` parameter of `AiDoc.ps1`.


Here are some usage examples:

```powershell
Import-Module -force ./powershai # Import powershai (using the module itself in the current directory to use the latest implemented features!)
Set-AiProvider google # Uses Google as the provider
Set-AiCredential # Configures the credentials of the Google provider (you only need to do this once)

# Example: Simple translation
util\aidoc.ps1 -SrcLang pt-BR -TargetLang en-US

# Example: Filtering specific files
util\aidoc.ps1 -SrcLang pt-BR -TargetLang en-US -FileFilter CHANGELOG.md

# Example: Translate to all available languages
gci docs | %{ util\aidoc.ps1 -SrcLang pt-BR -TargetLang $_.name }
```


# Versioning in PowershAI

PowershAI follows semantic versioning (or a subset of it).

The current version is controlled as follows:

1. Via Git tag in the format vX.Y.Z
2. [powershai.psd1](/powershai/powershai.psd1s) file

When a new version is created, a tag should be assigned to the last commit of that version.
All commits made since the last tag are considered part of that version.

In the [powershai.psd1] file, you must keep the version consistent with what was defined in the tag.
If it is incorrect, the automatic build will fail.

A PowershAI maintainer is responsible for approving and/or executing the new version workflow.

Currently, PowershAI is in version `0.`, as some things may change.
However, we are increasingly making it more stable, and the trend is that future versions will be much more compatible.

Version `1.0.0` will be officially released when there are sufficient tests by a portion of the community.

[powershai]: /powershai/powershai
[powershai.psm1]: /powershai/powershai.psm1
[powershai.psd1]: /powershai/powershai.psd1

