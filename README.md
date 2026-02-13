Install module
```
Install-Module -Name PSModulesCleanup -Repository PSGallery -Force
```

Examples:
Clear all PS modules leaving only the latest version
```
Clear-OldModules -LatestModulesToKeep 1 -CheckOnly $false
```

Leave the last 2 versions of the Microsoft.Graph.Beta modules. Run in test mode - without actual deletion. 
```
Clear-OldModules -ModulesFilter "Microsoft.Graph.Beta" -LatestModulesToKeep 2 -CheckOnly $true
```
