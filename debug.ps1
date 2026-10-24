C:\Infineon\AURIX-Configuration-Studio-1.0.24\eclipse\plugins\com.ifx.ads2.flash_2.0.24\AurixFlasherSoftwareTool\3.1.0.0\AURIXFlasher.exe `
-elf "$PSScriptRoot\lbuild\myapp.elf" -start off

# ACS project:
# Window -> Preferences -> Run/Debug -> Launching -> Uncheck 'Build (if required) before launching'
# Debug Configurations -> New TCF -> Project -> Uncheck 'Enable Flashing'
