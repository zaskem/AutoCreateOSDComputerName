# AutoCreateOSDComputerName
A simple Powershell script used to set the OSDComputerName variable for Dell machine [re]builds.
## Purpose
Since I don't want to type machine model numbers and flip over machines to identify a Dell service tag, this script auto-create a machine name based on variables collected from the source system. In this case, the naming convention is `<prefix><modelnum>-<dellservicetag>`, which for a Dell OptiPlex 7060 with Service Tag 1GX54Z2 will create a name like:

`MNS7060-1GX54Z2`
## Nuances
In a production environment/TS, the somewhat arbitrarily named SMSTS_DellMachineNameGenerated variable is how we logically handle other makes/models/situations in which using other scripts or displaying the naming prompt may be necessary.