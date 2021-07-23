# Set-ExecutionPolicy Bypass -Scope Process

$tmpDir = "$PSScriptRoot/tmp"

if (!(Test-Path $tmpDir)) {
    mkdir $tmpDir
}

function Uri-To-Filename($uri) {
    return $uri.split("/")[-1]
}

function File-Is-Missing($filename) {
    return !(Test-Path -Path $tmpDir/$filename)
}

function Download($uri) {
    $filename = Uri-To-Filename $uri

    Write-Output "Downloading ${filename}"

    Invoke-WebRequest $uri -OutFile $tmpDir/$filename
}

function Mount-ISO-And-Run($isoPath, $filename) {
    $mountResult = Mount-DiskImage -ImagePath $isoPath -PassThru
    $isoDrive = ($mountResult | Get-Volume).DriveLetter
    $runPath = "${isoDrive}:\$filename"

    $process = Start-Process $runPath -PassThru 
    $process.WaitForExit()

    Dismount-DiskImage -ImagePath $isoPath
}

function Install-Chocolatey {
    $isChocolateyInstalled = (Get-Command -Name choco.exe -ErrorAction SilentlyContinue)

    if ($isChocolateyInstalled) {
        Write-Output "Chocolatey already installed"
        return
    }

    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function Install-Chocolatey-Packages {
    choco feature enable -n allowGlobalConfirmation
    
    choco install vscode
    choco install git --version=2.32.0.2 
}

function Install-WPILib() {
    $uri = "https://github.com/wpilibsuite/allwpilib/releases/download/v2021.3.1/WPILib_Windows64-2021.3.1.iso"
    $filename = Uri-To-Filename $uri

    if (Test-Path C:/Users/Public/wpilib/2021) {
        Write-Output "WPILib already installed"
        return
    }

    if (File-Is-Missing $filename) {
        Download $uri
    }

    Write-Output "Launching WPILib Installer"

    $isoPath = "$tmpDir/$filename"
    Mount-ISO-And-Run $isoPath "WPILibInstaller"
}

Install-Chocolatey
Install-Chocolatey-Packages
Install-WPILib