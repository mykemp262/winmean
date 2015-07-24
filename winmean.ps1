# Install and configure the MEAN Framework (Mongo, Express.js, Angular.js and Node.js (and dependancies)
# Write test app, and test functionality.
# Install Sublime for development purposes.

# Setup Parameters:
$chocolateyExe = "C:\ProgramData\chocolatey\bin\choco.exe"
$mongoBin = "C:\MongoDB\2.6.1\bin\mongo.exe"
$nodeBin = "C:\Program Files\nodejs\node.exe"
$gitBin = "c:\Program Files (x86)\Git\cmd\git.exe"
$expressBin = "$Env:USERPROFILE\AppData\Roaming\npm\node_modules\express\lib\express.js"
$expressExe = "$Env:USERPROFILE\AppData\Roaming\npm\node_modules\express-generator\bin\express"
$bowerBin = "$Env:USERPROFILE\AppData\Roaming\npm\bower.cmd"
$gruntBin = "$Env:USERPROFILE\AppData\Roaming\npm\node_modules\grunt-cli\bin\grunt"
$bootstrapBin = "c:\foobar"
$angularBin = "c:\foobar"
$sublimeBin = "C:\Program Files\Sublime Text 3\sublime_text.exe"


# Sample App Configuration Parameters: 
$sampleAppBaseDir = "c:\mean"
$sampleAppDir = "c:\mean\testapp"
$sampleExpress = "testapp"


# Test Parameters
$testExpressURL = "http://localhost:3000/"
$testExpressFile = "C:\Users\Public\Downloads\expresstest.txt"


# Assert Function allows for easy testing of files/sites/webs etc.
# Run by calling Assert(<string>) if the string exists "TRUE" will be written in green if it fails "FALSE" will appear in red.
function Assert($Value)
{
    if($Value)
    {
        Write-Host -ForegroundColor GREEN "TRUE"
    }
    else
    {
        Write-Host -ForegroundColor RED "FALSE"
    }
}


# Install Chocolatey Packager Manager if Needed
$isChocolatey = Test-Path $chocolateyExe

if($isChocolatey -eq $True)
{
    Write-Host "Chocolatey is installed skipping to next step `n"
}
else
{
    $oldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
    
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
    
    $newPath=$oldPath+";C:\ProgramData\chocolatey\bin"
    
    SetItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
}

Write-Host "Testing: "$chocolateyExe
Assert(Test-Path $chocolateyExe | Select-String "True" -quiet)
Write-Host "`n"

# Install Sublime Text Editor for Development
$isSublime = Test-Path $sublimeBin

if($isSublime -eq $True)
{
    Write-Host "Sublime is installed skipping to next step `n"
}
else
{
    Invoke-Expression "$chocolateyExe  install sublimetext3 --confirm --force"
}

Write-Host "Testing: "$sublimeBin
Assert(Test-Path $sublimeBin | Select-String "True" -quiet)
Write-Host "`n"

# Install MongoDB
$isMongo = Test-Path $mongoBin

if($isMongo -eq $True)
{
    Write-Host "Mongo is installed skipping to next step `n"
}
else
{
    Invoke-Expression "$chocolateyExe  install mongodb.core.2.6 --confirm --force"
}

Write-Host "Testing: "$mongoBin
Assert(Test-Path $mongoBin | Select-String "True" -quiet)
Write-Host "`n"


# Install NodeJS
$isNode = Test-Path $nodeBin

if($isNode -eq $True)
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
    Write-Host "Node is installed updating... `n"
    Invoke-Expression """C:\Program Files\nodejs\npm update -g npm"""
    Write-Host "Node now updated - moving to next step `n"
}
else
{
    Invoke-Expression "$chocolateyExe  install nodejs --confirm --force"
    Write-Host "Updating NodeJS `n"
    Invoke-Expression """C:\Program Files\nodejs\npm update -g npm"""
    Write-Host "Node now updated - moving to next step `n"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
}

Write-Host "Testing: "$nodeBin
Assert(Test-Path $nodeBin | Select-String "True" -quiet)
Write-Host "`n"


# Install Git
$isGit = Test-Path $gitBin

if($isGit -eq $True)
{
    Write-Host "Git is installed moving to next step... `n"
    Invoke-Expression "git config --global url.""https://"".insteadOf git://"
}
else
{
    Invoke-Expression "$chocolateyExe  install git --confirm --force"
    Write-Host "Installing Git `n"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
    Invoke-Expression "git config --global url.""https://"".insteadOf git://"
}

Write-Host "Testing: "$gitBin
Assert(Test-Path $gitBin | Select-String "True" -quiet)
Write-Host "`n"


# Install Bower (Web Package Manager using NPM)
$isBower = Test-Path $bowerBin

if($isBower -eq $True)
{
    Write-Host "Bower is installed skipping to next step `n"
}
else
{
    Write-Host "Installing Bower..."
    Invoke-Expression "& 'C:\Program Files\nodejs\npm' install bower -g"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
}

Write-Host "Testing: "$bowerBin
Assert(Test-Path $bowerBin | Select-String "True" -quiet)
Write-Host "`n"


# Install Express (Express JS Framework using NPM )
$isExpress = Test-Path $expressBin

if($isExpress -eq $True)
{
    Write-Host "Express is installed skipping to next step `n"
}
else
{
    Write-Host "Installing Express"
    Invoke-Expression "& 'C:\Program Files\nodejs\npm' install express -g"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
}

Write-Host "Testing: "$expressBin
Assert(Test-Path $expressBin | Select-String "True" -quiet)
Write-Host "`n"


# Install Express Generator
$isExpressGen = Test-Path $expressExe

if($isExpressGen -eq $True)
{
    Write-Host "Express Generator is installed skipping to next step `n"
}
else
{
    Write-Host "Installing Express"
    Invoke-Expression "& 'C:\Program Files\nodejs\npm' install express-generator -g"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
}

Write-Host "Testing: "$expressBin
Assert(Test-Path $expressExe | Select-String "True" -quiet)
Write-Host "`n"


# Install Grunt (Install Grunt JS Task Manager/CLI using NPM )
$isGrunt = Test-Path $gruntBin

if($isGrunt -eq $True)
{
    Write-Host "Grunt is installed skipping to next step `n"
}
else
{
    Invoke-Expression "& 'C:\Program Files\nodejs\npm' install grunt-cli -g"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
}

Write-Host "Testing: "$gruntBin
Assert(Test-Path $gruntBin | Select-String "True" -quiet)
Write-Host "`n"


# FIXME: Do Stuff here - change to working directory, do some Express Setup, install Angular, install Bootstrap and Configure

# Set up Sample App Directory Structure (if needed).

# Check to see if Base App Dirctory Exists
$isBase = Test-Path $sampleAppBaseDir

if($isBase -eq $True)
{
    Write-Host $sampleAppBaseDir " Exits Creating... " 
    Set-Location -Path $sampleAppBaseDir
    $currentDir = Get-Location
    Write-Host "Working director is now: " $currentDir
}
else
{
    Write-Host "Creating... " $sampleAppBaseDir
    New-Item -ItemType Directory -Force -Path $sampleAppBaseDir
    Set-Location -Path $sampleAppBaseDir
    $currentDir = Get-Location
    Write-Host "Working director is now: " $currentDir
}

#Write-Host "Testing to ensure that we are in: "$sampleAppDir
#Assert($currentDir.tostring() | Select-String $sampleAppDir -quiet)
#Write-Host "`n"


# Create Express App using Express generator
$isExpressAppReady = Test-Path $sampleAppDir

if($isExpressAppReady -eq $True)
{
    Write-Host "Express has been run" # still working on this           
}
else
{
    #Invoke-Expression "$expressExe $sampleExpress"  # this doesn't work.
}

# Install Angular using Bower Web Package Manager
$isAngular = Test-Path $angularBin

if($isAngular -eq $True)
{
    Write-Host "Angular is installed skipping to next step `n"
}
else
{
    Invoke-Expression "$bowerBin --config.analytics=false install angular --quiet"
}

Write-Host "Testing: "$angularBin
Assert(Test-Path $angularBin | Select-String "True" -quiet)
Write-Host "`n"


# Install Bootstrap using Bower
$isBootstrap = Test-Path $bootstrapBin

if($isBootstrap -eq $True)
{
    Write-Host "Bootstrap is installed skipping to next step `n"
}
else
{
    Invoke-Expression "$bowerBin --config.analytics=false install bootstrap-css"
    Invoke-Expression "$bowerBin --config.analytics=false install bootstrap-javascript"
}

Write-Host "Testing: "$bootstrapBin
Assert(Test-Path $bootstrapBin | Select-String "True" -quiet)
Write-Host "`n"







#TODO Setup Test Site.












# FIXME!!!! LEAVING IN PLACE FOR NOW TO STUB OUT TEST CODE
# Test Site
#$testFileExists = Test-Path $testFile

#if($testFileExists -eq $True)
#{
#    Invoke-Expression "del $testFile"
#}

#Write-Host "Test Install `n`n`n"

#Invoke-WebRequest $testURL -OutFile $testFile

#Write-Host "Test for Hello, World: " 
#Assert(Get-Content $testFile | Select-String $testHello -quiet)
#Write-Host "Test for hello Jsp Link: " 
#Assert(Get-Content $testFile | Select-String $testHello -quiet)
#Write-Host "Test for hello Servlett Link: " 
#Assert(Get-Content $testFile | Select-String $testHello -quiet)

# Cleanup Test File
#Invoke-Expression "del $testFile"
