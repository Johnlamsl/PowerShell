#############################################################################
# Flickr Embed URL Image path Spliter
# Build to direct run with Powershell ISE Run button

# Ver 1.00 by John Lam - 2021-03-26
#############################################################################

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Warning -  This will change your clipboard  Embed URL path data to the Embed image("img src") only from you Clipboard if run
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#Remove Last use Variable
Remove-Variable ClipboardRaw -EA Ignore
Remove-Variable ClipboardSplit -EA Ignore

#Get Clipboard Raw Data
$ClipboardRaw = Get-Clipboard


if($ClipboardRaw -like '<a data-flickr-embed="true"*') #test is currently Clipboard data a Flickr Embed URL format
{
    Write-Host "Flickr Embed url found" -BackgroundColor DarkGreen -ForegroundColor White

    $ClipboardSplit = $clipboardRaw.Split("<") | foreach { if($_ -like "*>" ){ "<"+ $_} } #Split and tidy up the data format
    ($clipboardSplit | ?{$_ -like "<img src=*"}).Split('"')[1] | Set-Clipboard #find the "img src" path and Update the Clipboard

    Write-Host @("ClipboardConverted to : " + (Get-Clipboard) )  -BackgroundColor DarkGreen -ForegroundColor White
}
else
{
    Write-Host "Flickr Embed url Not Found found - No Action" -BackgroundColor DarkRed -ForegroundColor Yellow
}