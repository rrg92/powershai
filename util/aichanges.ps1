param(
	$PrevTag
	,$Provider = "google"
)

$Commits = @();
git log --ancestry-path --pretty=%h "$PrevTag..HEAD" |  %{
	$Commit = @{
		commit = $_
		category = $null 
		description = $null
	}
	
	write-host "Commit: $($Commit.commit)"
	
	$c = $Commit.commit;
	$diff = git log -p -1 $c
	
	$Commit.diff = $diff;
	
	$diffLines = @($diff -split "\r?\n" | %{"`t$_"} | select -first 8) -Join "`n"
	write-host "	$diffLines";
	
	$resp = Enter-AiProvider $Provider {
		$result = Get-AiChat -ContentOnly "Generate a description of that changes and classify change according with semantic versioning","changes:$diff" -ResponseFormat @{
				schema = @{
					type = "object"
					properties = @{
						description = @{
							type = "string"
							description = "The change description"
						}
						
						category = @{
							type = "string"
							description = "Change category"
							enum = "Added","Fix","Change","Removed"
						}	
					}

				}
			}
			
		$Commit.ai = $result | ConvertFrom-Json;
		$Commit.category = $Commit.ai.category
		$Commit.description = $Commit.ai.description
		
		write-host "	Cat: $($Commit.ai.category)"
		write-host "	$($Commit.ai.description)"
	}
	
	$Commits += [PsCustomObject]$Commit;
}


$ChangeLog = $Commits | sort Category | % { $cat = ""; } { 
	$d = $_.Description;  
	if($cat -ne $_.category){ 
		write-output "# $($_.category)"; 
		$cat = $_.category 
	}  

	write-output "- $d" 
} {  }