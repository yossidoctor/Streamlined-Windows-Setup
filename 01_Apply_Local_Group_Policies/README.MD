# Group Policy Update Script

This batch script automates the update and application of Group Policy Objects (GPOs) on Windows, requiring administrative privileges.

## Overview

The script performs:
1. **Admin Check**: Verifies the script is run as Administrator.
2. **Policy Cleanup**: Deletes existing GPO folders in `%WinDir%`.
3. **Policy Extraction**: Extracts `PolicyDefinitions21H2.zip` and copies the files to `%WinDir%`.
4. **Policy Application**: Applies registry-based policies using `lgpo.exe`.
5. **Group Policy Refresh**: Forces a Group Policy update.
6. **Report Generation**: Saves a `GPReport.html` on the desktop.

## Prerequisites

- **Admin Rights**: Run as Administrator.
- **Files**: Place the following in the same directory as the script:
  - `lgpo.exe` (Local Group Policy Object Utility)
  - `PolicyDefinitions21H2.zip` (updated policy definitions)
  - `machine_registry.pol` and `user_registry.pol` (registry-based policies)

## Usage

1. Right-click the script and select "Run as administrator."
2. A `GPReport.html` report will be generated on the desktop upon completion.
