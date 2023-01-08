$tmpDir = "$PSScriptRoot/tmp"

if (!(Test-Path $tmpDir)) {
    mkdir $tmpDir
}

function Get-Filename($uri) {
    return $uri.split("/")[-1]
}

function Is-File-Missing($filename) {
    return !(Test-Path $tmpDir/$filename)
}

function Download($uri) {
    $filename = Get-Filename $uri

    Write-Output "Downloading ${filename}"

    Invoke-WebRequest $uri -OutFile $tmpDir/$filename
}

function Mount-ISO-And-Run($isoPath, $filename) {
    $mountResult = Mount-DiskImage -ImagePath $isoPath -PassThru
    $isoDrive = ($mountResult | Get-Volume).DriveLetter
    $runPath = "${isoDrive}:/$filename"

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

    choco install git --version=2.39.0
}

function Install-WPILib() {
    if (Test-Path C:/Users/Public/wpilib/2023) {
        Write-Output "WPILib already installed"
        return
    }

    $uri = "https://github.com/wpilibsuite/allwpilib/releases/download/v2023.1.1/WPILib_Windows-2023.1.1.iso"
    $filename = Get-Filename $uri

    if (Is-File-Missing $filename) {
        Download $uri
    }

    Write-Output "Launching WPILib Installer"

    $isoPath = "$tmpDir/$filename"
    Mount-ISO-And-Run $isoPath "WPILibInstaller"
}

function Install-CTRE-Phoenix-Framework() {
    if (Test-Path "C:/Users/Public/Documents/Cross The Road Electronics") {
        Write-Output "CTRE Pheonix Framework already installed"

        $install = Read-Host "Would you like to install the 2023 version? (y/N)"

        if ($install -ne 'y') {
            return
        }
    }

    $uri = "https://github.com/CrossTheRoadElec/Phoenix-Releases/releases/download/v5.30.2.0/CTRE_Phoenix_Framework_v5.30.2.1.exe"
    $filename = Get-Filename $uri

    if (Is-File-Missing $filename) {
        Download $uri
    }

    Write-Output "Launching CTRE Pheonix Framework Setup"

    $runPath = "$tmpDir/$filename"
    $process = Start-Process $runPath -PassThru
    $process.WaitForExit()
}

function Uninstall-CTRE-Pheonix-Framework() {
    $runPath = "C:\Users\Public\Documents\Cross The Road Electronics"
    $process = Start-Process $runPath -PassThru
    $process.WaitForExit()
}

Install-Chocolatey
Install-Chocolatey-Packages
Install-WPILib
Install-CTRE-Phoenix-Framework
