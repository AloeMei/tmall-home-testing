$ErrorActionPreference = 'Stop'
# Self-contained build: inline data.json + standards_updates.json into index.html
# All paths resolved from script location; no Chinese literals in this file.
$root     = $PSScriptRoot
$tplPath  = Join-Path $root 'template.html'
$dataPath = Join-Path $root 'data.json'
$updPath  = Join-Path $root 'standards_updates.json'
$outPath  = Join-Path $root 'index.html'

$template = [System.IO.File]::ReadAllText($tplPath,  [System.Text.Encoding]::UTF8)
$json     = [System.IO.File]::ReadAllText($dataPath, [System.Text.Encoding]::UTF8)

$updates = '{"updates":[],"last_checked":null}'
if (Test-Path $updPath) {
    $updates = [System.IO.File]::ReadAllText($updPath, [System.Text.Encoding]::UTF8)
}

# Escape </ so inline JSON cannot terminate the script tag early
$jsonEsc = $json.Replace('</', '<\/')
$updEsc  = $updates.Replace('</', '<\/')

$m1 = '__DATA_JSON__'
$m2 = '__UPDATES_JSON__'
$i1 = $template.IndexOf($m1)
$i2 = $template.IndexOf($m2)
if ($i1 -lt 0) { throw 'marker __DATA_JSON__ not found in template.html' }
if ($i2 -lt 0) { throw 'marker __UPDATES_JSON__ not found in template.html' }

$html = $template.Substring(0, $i1) + $jsonEsc + $template.Substring($i1 + $m1.Length)
$html = $html.Replace($m2, $updEsc)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($outPath, $html, $utf8NoBom)

Write-Output ('BUILD OK  index.html=' + (Get-Item $outPath).Length + ' bytes  updates=' + $updates.Length + ' bytes')
