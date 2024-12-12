BeforeAll {
	import-module ./powershai -force;
}

AfterAll {
	Switch-PowershaiSetting default;
}

BeforeDiscovery {
	
}
	
Describe "Multiple settings" -Tag "core","basic","settings" {
	
	It "Different objects" {
		$Settings = Get-PowershaiSetting
		Switch-PowershaiSetting pester-1;
		$Settings = Get-PowershaiSetting
		$Settings.user | Should -not -be $Setting.user
	}
	
	It "Internal Variable Pointer" {
		
		Switch-PowershaiSetting default;
		
		InModuleScope powershai {
			$POWERSHAI_SETTINGS | Should -be $POWERSHAI_SETTINGS_V2.settings['default'].user;
		}
		
		Switch-PowershaiSetting pester-1
		
		InModuleScope powershai {
			$POWERSHAI_SETTINGS | Should -be $POWERSHAI_SETTINGS_V2.settings['pester-1'].user;
		}	
		
	}
	
}