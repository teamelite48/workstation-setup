# Workstation Setup for the 2023 FRC Season

1. **Run Setup Script**
    1. **Open** Windows PowerShell as Administrator
    1. **Run** `Set-ExecutionPolicy Bypass -Scope Process`
    1. **Accept** Execution Policy Change `Y`
    1. **Run** `./workstation-setup.ps1`
    1. **When** WPILIb Installer Opens
        1. **Click** Start
        1. **Select** Everything
        1. **Click** Install for this User
        1. **Click** Download for this computer only (fastest)
        1. **Click** Next
        1. **Click** Finish when installation is complete
    1. **If** asked to install the 2023 version of CTRE Pheonix Framework
        1. **Answer** `y`
    1. **When** CTRE Pheonix Framework Seteup Opens
        1. **Install** with default options
1. **Configure Git**
    1. **Open** Git Bash
    1. **Run** `git config --global user.name "your name"`
    1. **Run** `git config --global user.email your@email.com`
    1. **Run** `git config --global core.editor "notepad"`

# What's Included

* Chocolatey - software management automation
* Git 2.39.0 - version control for source code
* WPILIb 2023.1.1 - software library for FRC robots
* CTRE Phoenix Framework 5.30.2.1 - motor library and tools for Talon FX