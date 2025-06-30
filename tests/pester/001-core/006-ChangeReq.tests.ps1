BeforeAll {
	import-module ./powershai -force;
	$PowershaiTestUrl = "https://powersh.ai/http-test"
}


Describe "Http Lib Tests" -Tags "http" {
	
	It "GET request" {
		[string]$g1 = [Guid]::NewGuid();
		$result = Invoke-Http "$($PowershaiTestUrl)?g1=$g1"
		$obj = $result.text | ConvertFrom-Json 
		
		$obj.g1 | Should -be $g1;		
	}
	
	Context "Change Request Events" {
		
		BeforeAll {
			$ChangeTestData = @{};
			
			function Global:PowershaiHttpFilter {
				param($info)
				
				$ChangeTestData.events += $info.event;
				
				if($ChangeTestData.script){
					& $ChangeTestData.script $info;
				}
			}
		}
		
		AfterAll {
			Remove-Item "Function:\PowershaiHttpFilter";
		}
		
		BeforeEach {
			$ChangeTestData.script = $null;
			$ChangeTestData.events = @();
		}
		
		It "Correct events triggered" {
			$result = Invoke-Http "$($PowershaiTestUrl)"
			$ChangeTestData.events | Should -be "CreateStart","CreateEnd","GetStart","GetCompleted","CloseStart","CloseEnd","GetEnd","CloseStart","CloseEnd";
		}
		
		Context "Event CreateStart" {
			It "change GET parameter" {
				$g1 = [Guid]::NewGuid();
				$ChangeTestData.event = "CreateStart"
				
				$ChangeTestData.script = {
					param($info)
					
					if($info.event -eq "CreateStart"){
						$info.params.url.Value += "?g1="+$g1
					}
				}
				
				$result = Invoke-Http "$($PowershaiTestUrl)"
				$obj 	= $result.text | ConvertFrom-Json 
				
				$obj.g1 | Should -be $g1
			}
			
			It "change functon parameter (URL)" {
				$ChangeTestData.script = {
					param($info)
					
					if($info.event -eq "CreateStart"){
						$info.params.url.value = "https://huggingface.co/api/spaces/powershai/README"
					}
				}
				
				
				$result = Invoke-Http "$($PowershaiTestUrl)"
				$obj 	= $result.text | ConvertFrom-Json 
				
				$obj.id | Should -be "powershai/README"
			}
		}
		

		Context "Event GetStart" {
			It "change function parameter (timeout)" {
				$ChangeTestData.script = {
					param($info)
					
					if($info.event -eq "GetStart"){
						write-host "Changed timeout...";
						$info.params.Timeout.Value = 2000;
					}
				}
				
				{Invoke-Http "https://nghttp2.org/httpbin/delay/5"} | Should -Throw "timeout"
			}	
		}

		

		

		
	}

	
	
}