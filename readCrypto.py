import streamlit as st
import pandas as pd

"""
# Crypto Data
Is updated ***daily*** via a GitHub Action using PowerShell, Excel, and exporting to CSV.

At https://github.com/dfinke/TrackCrypto
"""

for coin in ["solana", "bitcoin", "dogecoin", "litecoin", "ethereum", "cardano", "chainlink", "uniswap"]:
    if st.checkbox('Show ' + coin):
        st.subheader(coin)
        st.write(pd.read_csv(
            "https://raw.githubusercontent.com/dfinke/TrackCrypto/master/" + coin + ".csv"))
