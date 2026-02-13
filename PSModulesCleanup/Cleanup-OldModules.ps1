Function Clear-OldModules
{
	[CmdletBinding()]
	Param (
		[Parameter()]
		[Bool]$CheckOnly = $true,
		[Parameter()]
		[String]$ModulesPath = "C:\Program Files\WindowsPowerShell\Modules",
		[Parameter()]
		[ValidateSet("AllUsers","CurrentUser")]
		[String]$Scope = "AllUsers",
		[Parameter()]
		[String]$ModulesFilter,
		[Parameter()]
		[ValidateRange(1, [Int]::MaxValue)]
		[Int]$LatestModulesToKeep = 1
	)

	#Check PSResourceGet module
	if(!(Get-Module Microsoft.PowerShell.PSResourceGet -ListAvailable))
	{
		Install-Module Microsoft.PowerShell.PSResourceGet -Repository PSGallery -Force
	}

	#Get all modules from path and group them by name
	$Modules = Get-PSResource -Path $ModulesPath -Scope $Scope | Sort-Object Version -Descending | Select-Object Name, Version | Group-Object Name
	if($ModulesFilter)
	{
		$Modules = $Modules | Where-Object { $_.Name -match $ModulesFilter }
	}

	#Process each module group and uninstall old versions, keeping only the latest one
	foreach ($Module in $Modules)
	{
		$LatestVersion = $Module.Group | Sort-Object Version -Descending | Select-Object -First 1 | Sort-Object Version | Select-Object @{l="Version";e={$_.Version.ToString()}} | Select-Object -ExpandProperty Version
		$KeepVersions = $Module.Group | Sort-Object Version -Descending | Select-Object -First $LatestModulesToKeep | Sort-Object Version | Select-Object @{l="Version";e={$_.Version.ToString()}} | Select-Object -ExpandProperty Version
		$OldVersions = $Module.Group | Sort-Object Version -Descending | Select-Object -Skip $LatestModulesToKeep | Sort-Object Version | Select-Object @{l="Version";e={$_.Version.ToString()}} | Select-Object -ExpandProperty Version

		Write-Host "Latest version of $($Module.Name): $($LatestVersion). Keep versions: [$($KeepVersions -join ', ')]" -ForegroundColor Green
		if($OldVersions.Count -gt 0)
		{
			Write-Host "Uninstall old versions of $($Module.Name): [$($OldVersions -join ', ')]" -ForegroundColor Yellow

			$StartVersion = $OldVersions | Select-Object -First 1
			$EndVersion = $OldVersions | Select-Object -Last 1

			if($false -eq $CheckOnly)
			{
				Uninstall-PSResource -Name $Module.Name -Version "[$StartVersion,$EndVersion]" -SkipDependencyCheck -Scope $Scope
			}
		}
	}
}

#Clear-OldModules -ModulesFilter "Microsoft.Graph.Beta" -LatestModulesToKeep 2 -CheckOnly $true
#Clear-OldModules -LatestModulesToKeep 1 -CheckOnly $true
