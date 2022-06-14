#Requires -RunAsAdministrator

function IsBinary()
{
  param ($Path)
  $nonPrintable = [char[]](0..8 + 10..31 + 127 + 129 + 141 + 143 + 144 + 157)
  $lines = Get-Content $Path -ErrorAction Ignore -TotalCount 5
  $result = @($lines | Where-Object { $_.IndexOfAny($nonPrintable) -ge 0 })
  if ($result.Count -gt 0)
  {
    return $true
  }

  return $false
}

Get-ChildItem -Path .\ -Recurse -File -Name| ForEach-Object {
  if (IsBinary $_)
  {
    Write-Host "$( $_ ) is binary, skipping" | Out-Host
  }
  else
  {
    Write-Host  "Converting $( $_ )" | Out-Host
    ((Get-Content $_) -join "`n") + "`n" | Set-Content -NoNewline $_
  }
}

New-Item -Path ".\builds\build_temp" -ItemType "directory" -ErrorAction Ignore

Write-Host "Building RHEL 9.0 base image" | Out-Host

packer build -force .

if ($LastExitCode -ne 0)
{
  throw "Packer failed please see logs for information"
}

Remove-Item -Path ".\builds\build_temp" -Force -Recurse