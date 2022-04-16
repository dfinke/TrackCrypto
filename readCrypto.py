import streamlit as st
import pandas as pd

"""
# Crypto Data
Is updated ***daily*** via a:
GitHub Action using PowerShell, Excel, and exporting to CSV: https://github.com/dfinke/TrackCrypto

### Show
"""

for coin in ["Solana", "Bitcoin", "Dogecoin", "Litecoin", "Ethereum", "Cardano", "Chainlink", "Uniswap"]:
    if st.checkbox(coin):
        st.write(pd.read_csv(
            "https://raw.githubusercontent.com/dfinke/TrackCrypto/master/" + coin.lower() + ".csv"))
