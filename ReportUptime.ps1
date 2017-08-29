Import-Module posh-git
cd C:\_git\WindowsUpdateUptime

$Content = Get-Content -Path 'C:\_git\WindowsUpdateUptime\README.md'

foreach ($Line in $Content) {
    if ($Line -like '*Win10-Pro-LoggedIn-GPO*') {
        $Pro1 = (Get-VM -Name Win10-Pro-LoggedIn-GPO).Uptime
        $Pro1Uptime = '<p id="Win10-Pro-LoggedIn-GPO">' + $Pro1.Days + ' days, ' + $Pro1.Hours + ' hours, ' + $Pro1.Minutes + ' minutes</p>'
        $Content = $Content -replace $Line, $Pro1Uptime
    }

    if ($Line -like '*Win10-Pro-LoggedOut-REG*') {
        $Pro2 = (Get-VM -Name Win10-Pro-LoggedOut-REG).Uptime
        $Pro2Uptime = '<p id="Win10-Pro-LoggedOut-REG">' + $Pro2.Days + ' days, ' + $Pro2.Hours + ' hours, ' + $Pro2.Minutes + ' minutes</p>'
        $Content = $Content -replace $Line, $Pro2Uptime
    }
    
    if ($Line -like '*Win10-Ent-LoggedIn-GPO*') {
        $Ent1 = (Get-VM -Name Win10-Ent-LoggedIn-GPO).Uptime
        $Ent1Uptime = '<p id="Win10-Ent-LoggedIn-GPO">' + $Ent1.Days + ' days, ' + $Ent1.Hours + ' hours, ' + $Ent1.Minutes + ' minutes</p>'
        $Content = $Content -replace $Line, $Ent1Uptime
    }

    if ($Line -like '*Win10-Ent-LoggedOut-REG*') {
        $Ent2 = (Get-VM -Name Win10-Ent-LoggedOut-REG).Uptime
        $Ent2Uptime = '<p id="Win10-Ent-LoggedOut-REG">' + $Ent2.Days + ' days, ' + $Ent2.Hours + ' hours, ' + $Ent2.Minutes + ' minutes</p>'
        $Content = $Content -replace $Line, $Ent2Uptime
    }
}

$Content | Set-Content -Path 'C:\_git\WindowsUpdateUptime\README.md'

$Timestamp = Get-Date -Format 'g'

git add .
git commit --message "Update VM Uptime - $Timestamp"
git push
