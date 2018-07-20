clear-host
$today = (Get-Date).ToString('MM_dd_yy')
$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
$logFile = "C:\Users\jczebiniak\_Next_home\youtube-vids\_LOGS\$today-log.txt"
Start-Transcript -path $logFile -append
$downlist = @()
$count = 0
function aggregate_items {
[string]$a = $null
$a = $downlist -join " , "
$curr_pos = $downlist.Length + 1
clear-host
write-host "List so far:" $a
write-host ""
write-host "Current item number:" $curr_pos
write-host ""
write-host "To finish, just hit enter."
write-host ""
$url = Read-host -Prompt "URL"
return $url
}
do
{
$link = aggregate_items
if ($link -ne "") { $downlist += $link }
}
until ($link -eq "")
clear-host
write-host ""
write-host "Downloading your list..."
write-host ""
#write-host "LENGTH: "$Global:downlist.Length
#For ($i=0; $i -lt $Global:downlist.Length; $i++)
#    {write-host "ITEM"$i ":" $Global:downlist[$i]}
foreach($item in $downlist)
    {++$count
    write-host "downloading item " $count " of " $downlist.Length
    #write-host $item
    youtube-dl $item
    }
write-host "Finished."
Stop-Transcript
pause
exit