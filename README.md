# Install module
```
Install-Module -Name PSModulesCleanup -Repository PSGallery -Force
```

# Examples:

**Clear all PS modules leaving only the latest version.** 
```
Clear-OldModules -LatestModulesToKeep 1 -CheckOnly $false
```

**Leave the last 2 versions of the Microsoft.Graph.Beta modules. Run in test mode - without actual deletion.** 
```
Clear-OldModules -ModulesFilter "Microsoft.Graph.Beta" -LatestModulesToKeep 2 -CheckOnly $true
```

**MacOS example. Leave the last 2 versions of the Microsoft.Graph.Beta.DirectoryManagement modules.** 
```
Clear-OldModules -ModulesFilter "Microsoft.Graph.Beta.Identity" -LatestModulesToKeep 2 -ModulesPath /Users/username/.local/share/powershell/Modules
```
Result
```
Latest version of Microsoft.Graph.Beta.Identity.DirectoryManagement: 2.35.0. Keep versions: [2.34.0, 2.35.0]
Uninstall old versions of Microsoft.Graph.Beta.Identity.DirectoryManagement: [2.32.0]
Latest version of Microsoft.Graph.Beta.Identity.Governance: 2.35.0. Keep versions: [2.34.0, 2.35.0]
Uninstall old versions of Microsoft.Graph.Beta.Identity.Governance: [2.32.0]
Latest version of Microsoft.Graph.Beta.Identity.Partner: 2.35.0. Keep versions: [2.34.0, 2.35.0]
Uninstall old versions of Microsoft.Graph.Beta.Identity.Partner: [2.32.0]
Latest version of Microsoft.Graph.Beta.Identity.SignIns: 2.35.0. Keep versions: [2.34.0, 2.35.0]
Uninstall old versions of Microsoft.Graph.Beta.Identity.SignIns: [2.32.0]
```
