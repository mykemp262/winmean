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
$bootstrapBin = "C:\mean\testApp\bower_components\bootstrap-css\bower.json"
$angularBin = "C:\mean\testApp\bower_components\angular\angular.js"
$sublimeBin = "C:\Program Files\Sublime Text 3\sublime_text.exe"

$npmBase = "$Env:USERPROFILE\AppData\Roaming\npm"

# Sample App Configuration Parameters: 
$sampleAppBaseDir = "c:\mean"
$sampleAppDir = "c:\mean\testapp"
$sampleExpress = "testApp"


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
    
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
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

# Set Express in path

$oldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path


$isExpressInPath = $oldPath | Select-String "C:\\Users\\mkempa\\AppData\\Roaming\\npm" -quiet



if($isExpressInPath -eq $True)
{
    
    Write-Host "Express is in Path moving to next step..."

}

else

{

    Write-Host "Adding C:\Users\mkempa\AppData\Roaming\npm to path so that Express will work"
    $newPath=$oldPath+";C:\Users\mkempa\AppData\Roaming\npm"
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath


    Write-Host "Reloading Environment Path..."
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

}


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

# Set up Sample App Directory Structure (if needed).

# Check to see if Base App Dirctory Exists
$isBase = Test-Path $sampleAppBaseDir

if($isBase -eq $True)
{
    Write-Host $sampleAppBaseDir " Exits Changing to... " $sampleAppBaseDir 
    Set-Location -Path $sampleAppBaseDir
    $currentDir = Get-Location
    Write-Host "Working directory is now: " $currentDir
}
else
{
    Write-Host "Creating... " $sampleAppBaseDir
    New-Item -ItemType Directory -Force -Path $sampleAppBaseDir
    Set-Location -Path $sampleAppBaseDir
    $currentDir = Get-Location
    Write-Host "Working directory is now: " $currentDir
}


# Create Express App using Express generator
$isExpressAppReady = Test-Path $sampleAppDir

if($isExpressAppReady -eq $True)
{
    Write-Host "Express has been run"          
}
else
{
    Invoke-Expression "npm ls -g --depth=0"
    Write-Host $env:Path
    Invoke-Expression "express $sampleExpress" 
}

$isBase = Test-Path $sampleAppDir

if($isBase -eq $True)
{
    Write-Host $sampleAppDir " Exits Changing to... " $sampleAppDir 
    Set-Location -Path $sampleAppDir
    $currentDir = Get-Location
    Write-Host "Working directory is now: " $currentDir
}
else
{
    Write-Host express did not configure APP correctly - installation will continue but site will most likely not work.
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

# Test to see if we need to configure Express
$isExpressRunning = Test-NetConnection -ComputerName localhost -Port 3000 -InformationLevel Quiet

if($isExpressRunning -eq $True)
{
    Write-Host "Moving on to tests..."
}
else
{
    Write-Host "Setting up Express App"
    Invoke-Expression "npm install"
    Invoke-Expression "SET DEBUG=testApp:*" 
    Start-Process npm start
}    

# Test Site
$testFileExists = Test-Path $testExpressFile

if($testFileExists -eq $True)
{
    Invoke-Expression "del $testExpressFile"
}

Invoke-WebRequest $testExpressURL -OutFile $testExpressFile

Write-Host "Test for Express: " 
Assert(Get-Content $testExpressFile | Select-String "Express" -quiet)

Write-Host "Welcome to Express: " 
Assert(Get-Content $testExpressFile | Select-String "Welcome to Express" -quiet)

Write-Host "All of the MEAN Components have been setup, and Express has been tested"

# Cleanup Test File
Invoke-Expression "del $testExpressFile"
