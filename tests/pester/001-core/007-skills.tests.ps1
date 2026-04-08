Describe "Get-AiSkills" -Tags "skills","core:skills" {

    BeforeAll {
        Import-Module ./powershai -Force

        $script:SkillsFixtureRoot = Join-Path $PSScriptRoot "fixtures/skills"
        $script:BasicSkillDir = Join-Path $script:SkillsFixtureRoot "basic-no-script"
        $script:ScriptSkillDir = Join-Path $script:SkillsFixtureRoot "echo-with-script"
    }

    It "Loads both skills when passing root directory" {
        $Skills = @(Get-AiSkills -Path $script:SkillsFixtureRoot -Recurse)

        $Skills.Count | Should -Be 2
        @($Skills.name | Sort-Object) | Should -Be @("basic-no-script","echo-with-script")
    }

    It "Loads basic skill with expected format" {
        $Basic = @(Get-AiSkills -Path $script:BasicSkillDir)[0]

        $Basic.name | Should -Be "basic-no-script"
        $Basic.description | Should -BeLike "Basic skill without scripts*"
        $Basic.location | Should -BeLike "*SKILL.md"
        $Basic.skillDir | Should -BeLike "*basic-no-script"
        $Basic.body | Should -BeLike "*Basic No Script*"
        $Basic.resources.Count | Should -Be 0
    }

    It "Loads script skill and exposes script resource" {
        $WithScript = @(Get-AiSkills -Path $script:ScriptSkillDir)[0]

        $WithScript.name | Should -Be "echo-with-script"
        $WithScript.description | Should -BeLike "Skill that ships a simple script resource*"
        $WithScript.location | Should -BeLike "*SKILL.md"
        $WithScript.skillDir | Should -BeLike "*echo-with-script"
        $HasEchoScript = @($WithScript.resources | Where-Object { $_ -match 'scripts[\\/]echo\.ps1$' }).Count -gt 0
        $HasEchoScript | Should -Be $true
    }

    It "Loads one skill when passing exact basic skill directory" {
        $Skills = @(Get-AiSkills -Path $script:BasicSkillDir)

        $Skills.Count | Should -Be 1
        $Skills[0].name | Should -Be "basic-no-script"
    }

    It "Loads one skill when passing exact script skill directory" {
        $Skills = @(Get-AiSkills -Path $script:ScriptSkillDir)

        $Skills.Count | Should -Be 1
        $Skills[0].name | Should -Be "echo-with-script"
    }
}
