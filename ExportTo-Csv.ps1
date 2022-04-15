$xlfile = 'charts.xlsx'

foreach($sheet in Get-ExcelSheetInfo $xlfile) {
    $csvFile = $sheet.Name + ".csv"  
    Import-Excel $xlfile $sheet.Name | Export-Csv $csvFile
}