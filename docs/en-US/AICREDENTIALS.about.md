# AI Credentials


# Introduction <!--! @#Short -->

AI Credentials is a powershai mechanism that allows you to configure credentials and access tokens for provider APIs.


# Details <!--! @#Long -->

Most providers available in powershai require some type of authentication.
Whether via API Token, JWT, oauth, etc., it may be necessary to provide some type of credential.

Early versions of Powershai allowed each provider to implement its own authentication commands.
However, since this is a common process for almost every provider, we understood that it was important to standardize how these credentials are created and accessed.
Thus, users have a standard way to authenticate themselves, always using the same commands, which is easier, even to get help.

With that, AI Credentials was born: A standard powershai mechanism for managing provider credentials.


## Defining credentials

To create a new credential, use Set-AiCredential:

```powershell
Set-AiCredential
```

Set-AiCredential is an alias for the definitive command defined by the current provider.
Each provider can provide a specific implementation, which contains its own code and parameters.

PowershAI manages where this alias points to as the provider is changed.

The provider may provide additional parameters, so `Set-AiCredential` may contain different parameters depending on the provider.
Another way to define credentials is using environment variables. Each provider can define the list of possible variables.

Use `get-help Set-AiCredential` or consult the provider's documentation for more details and guidance on how to provide the parameters and environment variables.

Optionally, you can define a name and description for the credential using the `-Name` `-Description` parameter.
If the name is not specified, it will use a default name.

If a credential with the name already exists, it asks if you want to replace it. You can use -force to skip the confirmation.


## Using credentials

Providers interact with AI Credentials through the `Get-AiDefaultCredential` command.
You can use the command to check which credential will be used by the active provider.

To avoid using incorrect tokens, powershai now uses the strategy of not using a credential if there is no guarantee that it is the user's intention to use it.

Based on this, this command returns the default credential. Powershai defines a default credential following these rules:

* If there is only 1 credential, it is the default
* Otherwise, the user must explicitly define the default using Set-AiDefaultCredential

Credentials defined via environment variables are treated as default.
However, if a credential has been defined via an environment variable and there is a credential explicitly defined as default, then powershai returns an error.

Thanks to this mechanism, all providers can, in a standard way, obtain credentials defined by the user, under the same validation mechanisms, while maintaining the differences in information that may be necessary.


Remember that to obtain more information and help, you can use the Get-Help `Command` command. AiCredential commands tend to contain many operational details not documented in this topic.


<!--PowershaiAiDocBlockStart-->
_Automatically translated using PowershAI and AI
_
<!--PowershaiAiDocBlockEnd-->
