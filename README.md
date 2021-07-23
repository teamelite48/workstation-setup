# Workstation Setup

1. **Run Setup Script**
    1. **Open** Windows PowerShell as Administrator
    1. **Run** `Set-ExecutionPolicy Bypass -Scope Process`
    1. **Accept** Execution Policy Change `Y` 
    1. **Run** `workstation-setup.ps1`
1. **Configure Git**
    1. **Open** Git Bash
    1. **Run** `git config --global user.name "your name"`
    1. **Run** `git config --global user.email your@email.com`
    1. **Run** `git config --global core.editor "code"`

## What's Included
* Chocolatey - software management automation
* Git - version control for source code
* Visual Studio 2019 Community with C++ - required to build robot simulation using C++
* Visual Studio Code - code editor
* WPILIb 2021.3.1 - software library for FRC robots