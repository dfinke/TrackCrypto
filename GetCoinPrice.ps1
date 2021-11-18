function Get-CoinPrice {
    # https://www.reddit.com/r/PowerShell/comments/mx8xw4/using_powershell_to_look_up_crypto_prices/
    # https://www.coingecko.com
    param (

        [Parameter(Position = 0, Mandatory = $True, ValueFromPipeline = $false)]
        [String[]] $Coins,
        [ValidateSet('aed', 'ars', 'aud', 'bch', 'bdt', 'bhd', 'bmd', 'bnb', 'brl', 'btc',
            'cad', 'chf', 'clp', 'cny', 'czk', 'dkk', 'eos', 'eth', 'eur', 'gbp', 'hkd', 'huf',
            'idr', 'ils', 'inr', 'jpy', 'krw', 'kwd', 'lkr', 'ltc', 'mmk', 'mxn', 'myr', 'nok',
            'nzd', 'php', 'pkr', 'pln', 'rub', 'sar', 'sek', 'sgd', 'thb', 'try', 'twd',
            'uah', 'usd', 'vef', 'vnd', 'xag', 'xau', 'xdr', 'xlm', 'xrp', 'zar')]
        [String] $Currency = 'usd',
        [ValidateSet('Symbol', 'ID', 'Name', 'Price', 'Rank', 'MarketCap')]
        [string] $Sort = 'Rank'
    )

    Foreach ($coin in $Coins) {
        $IDS += ($coin.ToLower() + "%2C")        
    }

    Try {
        # $uri = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=$Currency&ids=$IDS&order=market_cap_desc&per_page=100&page=1&sparkline=false"
        $uri = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=$Currency&ids=$IDS&per_page=100&page=1&sparkline=false"
        $AllCryptos = (Invoke-WebRequest -uri $uri).Content | ConvertFrom-Json
    }
    Catch {
        $Exception = $_.Exception.Message
        Write-Error "Cannot connect to the coingecko.com API. Here's the error: $Exception"
        break
    }
    $AllCryptos
}

$xlFilename = "./coins.xlsx"
$coins = Get-Content ./coins.txt

$data = Get-CoinPrice $coins 
$selectedData = $data | Select-Object symbol, id, name, current_price, market_cap_rank, market_cap, max_supply, total_supply, last_updated

$ts = (Get-Date).ToString("yyyyMMddHHmmss")
$workSheetName = $ts + (Get-Date).ToString(" - MMM dd yyyy") 

$xlparams = @{
    path          = $xlFilename 
    WorksheetName = $workSheetName
    TableName     = "data$($ts)"
    AutoSize      = $true
    AutoFilter    = $true
    AutoNameRange = $true    
    passthru      = $true
    Activate      = $true
}

$xlpkg = $selectedData | Export-Excel  @xlparams 

Set-ExcelRange -Worksheet $xlpkg.$workSheetName -Range current_price -NumberFormat 'Currency'
Set-ExcelRange -Worksheet $xlpkg.$workSheetName -Range market_cap -NumberFormat '#,#' -AutoSize
Set-ExcelRange -Worksheet $xlpkg.$workSheetName -Range total_supply -NumberFormat '#,#' -AutoSize
Set-ExcelRange -Worksheet $xlpkg.$workSheetName -Range max_supply -NumberFormat '#,#' -AutoSize

Close-ExcelPackage $xlpkg -Show