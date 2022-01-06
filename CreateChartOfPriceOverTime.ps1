$symbols = Get-Content coins.txt | Sort-Object

$xlfileName = 'coins.xlsx'

$worksheets = Get-ExcelFileSummary $xlfileName | Sort-Object worksheetname 

$xlChartFileName = 'charts.xlsx'
Remove-Item $xlChartFileName -ErrorAction SilentlyContinue

$h = [ordered]@{}
foreach ($worksheet in $worksheets) {
    foreach ($symbol in $symbols) {
        if (!$h.Contains($symbol)) {
            $h["$symbol"] = @()
        }
        $h["$symbol"] += Import-Excel -Path $xlfileName -WorksheetName $worksheet.worksheetname | 
        Where-Object { $_.id -eq $symbol } | 
        Select-Object id, symbol, current_price, @{n = 'last_updated'; e = { (Get-Date $_.last_updated).ToString("MM/dd/yyyy") } }
    }
}

$cd = New-ExcelChart -XRange last_updated -YRange current_price -NoLegend -ChartType Line

foreach ($entry in $h.GetEnumerator()) {
    $cd.Title = "$($entry.Key)`nCurrent Price Over Time"
    $entry.Value | Export-Excel $xlChartFileName -WorksheetName $entry.Key -AutoSize -AutoFilter -AutoNameRange -ExcelChartDefinition $cd
}

Invoke-Item $xlChartFileName