# Workstation Setup

1. **Run Setup Script**
    1. **Open** Windows PowerShell as Administrator
    1. **Run** `Set-ExecutionPolicy Bypass -Scope Process`
    1. **Accept** Execution Policy Change `Y` 
    1. **Run** `workstation-setup.ps1`
    1. **When** WPILIb Installer Opens
        1. **Click** Start
        1. **Click** Download VS Code for Single Install
        1. **Click** Install for this User
        1. **Click** Finish when installation is complete
    1. **When** CTRE Pheonix Framework Seteup Opens
        1. **Install** with default options
1. **Configure Git**
    1. **Open** Git Bash
    1. **Run** `git config --global user.name "your name"`
    1. **Run** `git config --global user.email your@email.com`
    1. **Run** `git config --global core.editor "nano"`

# What's Included
* Chocolatey - software management automation
* Git - version control for source code
* Visual Studio 2019 Community with C++ - required to build robot simulation using C++
* WPILIb 2021.3.1 - software library for FRC robots
* CTRE Phoenix Framework 5.19.4.1 - motor library and tools for Talon FX