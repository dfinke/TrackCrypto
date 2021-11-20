function Get-CoinPrice {
    # https://www.reddit.com/r/PowerShell/comments/mx8xw4/using_powershell_to_look_up_crypto_prices/
    # https://www.coingecko.com
    param (

        [Parameter(Mandatory, ValueFromPipeline)]
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