$file = 'C:\Users\ishay\Desktop\mytask.txt'
$date = Get-Date
if (-not(Test-Path -Path $file -PathType Leaf)) {
	$null = New-Item -ItemType File -Path $file
	Set-Content "$file" "$date"

 }
else {
	Set-Content "$file" "$date"
 }
