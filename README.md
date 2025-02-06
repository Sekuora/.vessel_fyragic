The vessel template is intended to work on windows using the Developer Powershell Environment.
I want to expand the system for other platforms and make it a python library or a console based application with more robust commands.

This is the first iteration of a project that I call univessel.
Consists of a tool that manages the initial setup for external dependencies such as python's virtual environments.
The environments are called vessels.

For now we have the .vessel-main-template which attempts to emulate that behavior.

# Alpha Version Notice
Preferably test it on new projects to see if it works out for you.

# About this template:

### .vessel-main-template
Template to setup vcpkg dependencies automatically.

### .vessel setup script
The Initvessel scripts provide the basic generation for the vcpkg dependency inside of a project.


## Recommended steps to run
1. In github, **press the create template button** to create a template vessel for your specific projects and dependencies.
2. A naming recommendation is .vessel_<project_name> example:
   - vessel_fyragic-engine (contains the depdendencies for my game engine project)
3. Clone your .vessel template in a project or standalone in any folder of your system.
  
4. Define your dependencies using a manifest vcpkg file, a vcpkg.json. Refer to microsoft vcpkg docs for manifest files format:

- https://learn.microsoft.com/en-us/vcpkg/get_started/get-started?pivots=shell-powershell

5. Run the script ***initvesselenv.ps1***
- The script will setup the **.vessel** directory and a **externals** directory where vcpkg will go.
- You will be prompted if you want to clone vcpkg into your vessel or add it as a submodule. (Choose either, I prefer creating it as a submodule)
- Then the script will install all your dependencies inside the vcpkg directory local to your project. at:

.vessel/externals/vcpkg/packages

6. Link the required directories.

## Issues
- While not critical: Ideally the directory of the vcpkg_installed folder should be inside of the .vessel environment.

## Future Ideas
- Need to work on a cleaner integration and setup.
- Test the script actions and come up with a better workflow.
- Test integration of libraries with other build tools.

    

