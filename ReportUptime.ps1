Start-Transcript -Path c:\_git\trans.log -Append
Import-Module posh-git
cd C:\_git\WindowsUpdateUptime

$Content = Get-Content -Path 'C:\_git\WindowsUpdateUptime\README.md'

foreach ($Line in $Content) {
    if ($Line -like '*Win10-Pro-LoggedIn*') {
        $Pro1 = (Get-VM -Name WIN_PRO_10_1703).Uptime
        $Pro1Uptime = '<p id="Win10-Pro-LoggedIn">' + $Pro1.Days + ' days, ' + $Pro1.Hours + ' hours, ' + $Pro1.Minutes + ' minutes</p>'
        $Content = $Content -replace $Line, $Pro1Uptime
    }
    
    if ($Line -like '*Win10-Ent-LoggedOut*') {
        $Ent1 = (Get-VM -Name WIN_ENT_10_1703).Uptime
        $Ent1Uptime = '<p id="Win10-Ent-LoggedOut">' + $Ent1.Days + ' days, ' + $Ent1.Hours + ' hours, ' + $Ent1.Minutes + ' minutes</p>'
        $Content = $Content -replace $Line, $Ent1Uptime
    }
}

$Content | Set-Content -Path 'C:\_git\WindowsUpdateUptime\README.md'

$Timestamp = Get-Date -Format 'g'

git add .
git commit --message "Update VM Uptime - $Timestamp"
git push
