$files = Get-ChildItem .\
foreach ($f in $files){
$outfile = $f.FullName + "_utf8.txt"
    Get-Content $f.FullName | Set-Content -Encoding Ascii $outfile
}