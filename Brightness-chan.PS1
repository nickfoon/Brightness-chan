# rerun
$choices = [System.Management.Automation.Host.ChoiceDescription[]] @("&Y","&N")
while ( $true ) {

    # display current brightness
    $current = (Get-WmiObject -Namespace root\wmi -Class WmiMonitorBrightness).CurrentBrightness
    Write-Host 'The Current Brightness is'$current'%'

    # keep asking for brightness until valid data entered
    do {
        try {    
            $numOK = $true
            [int]$Brightness = Read-Host -Prompt 'Change to'
            if (($Brightness -lt 0) -or ($Brightness -gt 100)) {
                Write-Host 'Error, please enter a number between 1-100'
            }
        }
        # catch errors
        catch {$numOK = $false}
    }
    until (($Brightness -ge 0) -and ($Brightness -le 100) -and $numOK)

    # change brightness
    (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,$Brightness)

    # prompt for rerun or close
    $choice = $Host.UI.PromptForChoice("The Current Brightness is now $brightness%, do you wish to change it?","",$choices,0)
    if ( $choice -ne 0 ) {
        break
    }
}