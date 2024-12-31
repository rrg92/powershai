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

The `powershai` directory is the module itself, that is, the PowershAI source code.
Like any PowerShell module, it contains a .psm1 file and a .psd1 file.
The `powershai.psm1` file is the root of the module, that is, it is the file that is executed when you run `Import-Module powershai`.
The `powershai.psd1` file is the module manifest, which contains important metadata about the module, such as version, dependencies, and copyright.

The other files are loaded by `powershai.psm1`, automatically or as certain commands are executed.
Initially, all the PowershAI source code was in the `powershai.psm1` file, but as it grows, it becomes better for development to separate it into smaller files, grouped by functionality. As new versions are released, new structures and files may emerge for better organization.

Here is a brief summary of the most important files and/or directories:

- [lib]
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
One of the goals we have for PowershAI is that all commands have a unit test defined, in addition to the tests that validate more complex features.
Since PowershAI started without tests, it is likely that there are still many commands without tests.
But, as these commands are modified, or new ones are added, it is mandatory that the tests are defined and adjusted.

To create a test, you must use the [Pester module 5 syntax](https://pester.dev/docs/quick-start).
The directory where the test script will look is `tests/pester`, so you should put the files there.
Only files with the extension `.tests.ps1` will be loaded.
The organization of the test structure is documented via
