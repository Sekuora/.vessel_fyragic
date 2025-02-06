# Set Developer PowerShell Environment
Import-Module "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
Enter-VsDevShell 0c27c85d

# Wait a bit to set it up
Start-Sleep -Seconds 5

# Go to current script location
Set-Location -Path $PSScriptRoot

git status



# Add the .vessel git submodule if path doesn't exist
$vesselPath = Join-Path $PSScriptRoot ".vessel"
$externalsPath = Join-Path $vesselPath "externals"
$vcpkgPath = Join-Path $externalsPath "vcpkg"
$vcpkgInstalledPath = Join-Path $externalsPath "vcpkg_installed"

# Create Paths for .vessel and externals (external libraries / dependencies)
if (-Not (Test-Path $vesselPath))
{
# vessel root dir
mkdir .vessel

cd .vessel

if (-Not (Test-Path $externalsPath))
{
mkdir externals
# enter externals
cd externals

Write-Output "external libraries / dependencies root created."


}

else
{
    Write-Output "external libraries / root already exists."
}

Write-Output ".vessel environment created."
}
else
{
Write-Output ".vessel environment already exists."
}

Set-Location -Path $externalsPath


# add vcpkg
if (-Not (Test-Path $vcpkgPath)) {
    # Choose VCPKG Actions
    $choice = Read-Host "vcpkg can be created. Choose an option:
    1. Clone the vcpkg repository
    2. Add vcpkg as a submodule
    3. Exit without configuring vcpkg"

    switch ($choice) {
        "1" {
            # Option 1: Clone the vcpkg repository
            Write-Output "Cloning the vcpkg repository..."
            git clone https://github.com/microsoft/vcpkg.git
            Write-Output "vcpkg repository cloned."

            while (-Not (Test-Path $vcpkgPath)) {
             Write-Output "Waiting for the vcpkg repository to be created..."
                Start-Sleep -Seconds 1
            }

             Write-Output "vcpkg added successfully."
        }
        "2" {
            # Option 2: Add vcpkg as a submodule
            Write-Output "Adding vcpkg as a submodule..."
            git submodule add https://github.com/microsoft/vcpkg.git
            Write-Output "vcpkg added as a submodule."

            while (-Not (Test-Path $vcpkgPath)) {
            Write-Output "Waiting for the vcpkg repository to be created..."
                Start-Sleep -Seconds 1
            }

             Write-Output "vcpkg added successfully."
             }

        "3" { 
            
            #Option 3: Abort and exit
            exit
        }
        default {
            Write-Output "Invalid choice. Please choose either 1 or 2."
        }
    }
} else {
    Write-Output "vcpkg already exists at $vcpkgPath"
}

# Go to vcpkg path
Set-Location -Path $vcpkgPath


# Execute default vcpkg configuration
.\bootstrap-vcpkg.bat


# Set VCPKG Local environment variables
$env:VCPKG_ROOT = "$vcpkgPath"
$env:PATH = "$env:VCPKG_ROOT;$env:PATH"

# $env:VCPKG_ENABLE_FEATURES_EXPERIMENTAL = "1"

Set-Location -Path $PSScriptRoot

# Create the vcpkg manifest file and install dependencies
vcpkg new --application

### vcpkg add ports ###

# Test spdlog port uncomment line down below.
vcpkg add port spdlog


# Install the dependencies added to the ports.
vcpkg install 



Read-Host -Prompt "Finished Setting Up .vessel environemnt and installed vcpkg dependencies! Press Enter to exit"


