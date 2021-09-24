#region Printers to install
$printers = @(
    [PSCustomObject]@{
        Printer = "FollowMePrint"
        Server = "nkpsrv13.itg-larande.local"
    }
)
#endregion
#region functions
Function Detect-LocalPrinters {
    <#
    .SYNOPSIS
        Detects network printer to local machine.
    .PARAMETER Server
        FQDN or IP Address of print server
    .PARAMETER printerName
        Name of printer to be detected
    #>
    param (
        [string]$server,

        [string]$printerName
    )
    $printerPath = $null
    $PrinterPath = "\\$($server)\$($printerName)"

    if (Get-Printer -Name "$printerPath" -ErrorAction SilentlyContinue) {
        Write-Host "Printer $printerPath detected" -ForegroundColor Green
    }
    else {
        Write-Host "Printer $printerPath not detected" -ForegroundColor Green
    exit 1
    }

}
#endregion
#region Install printers
foreach ($p in $printers) {
    Detect-LocalPrinters -server $p.Server -printerName $p.Printer
}
#endregion