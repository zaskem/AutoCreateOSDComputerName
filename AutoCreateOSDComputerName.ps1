<# Header
 File Name: AutoCreateOSDComputerName.ps1
 Summary: Simple script to auto-craft the OSDComputerName variable based on a standard naming convention for Dell models.
 Created by: Matt Zaske
 Version 1.0

 Purpose
 =======
 Auto-create a machine name based on variables collected from the source system (opposed to typing, because nobody has time for that). In this case, the naming convention is <prefix><modelnum>-<dellservicetag>, which for a Dell OptiPlex 7060 with Service Tag 1GX54Z2 will create a name like:
 MNS7060-1GX54Z2

 Nuances
 =======
 In production environment/TS, the SMSTS_DellMachineNameGenerated variable is how we logically handle other makes/models/situations in which the naming prompt may be necessary.

 #>
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$tsenv.Value("OSDComputerName") = ""
$tsenv.Value("SMSTS_DellMachineNameGenerated") = "False"

$Prefix = "MNS"
$Make = (Get-WmiObject Win32_ComputerSystem).Manufacturer
$Model = (Get-WmiObject Win32_ComputerSystem).Model
$ServiceTag = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty SerialNumber

If ($Make.StartsWith("Dell", $true, $null)) {
    # We only want the numeric part of the machine model
    $ModelNumber = $Model -replace '\D+(\d+)', '$1'
    $tsenv.Value("OSDComputerName") = $Prefix + $ModelNumber + "-" + $ServiceTag
    $tsenv.Value("SMSTS_DellMachineNameGenerated") = "True"
}
