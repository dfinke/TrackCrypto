import streamlit as st
import pandas as pd

"""
# Crypto Data
Is updated ***daily*** via a:

GitHub Action using PowerShell, Excel, and exporting to CSV: https://github.com/dfinke/TrackCrypto
"""

@st.cache
def load_data(targetID):
    URL = "https://raw.githubusercontent.com/dfinke/TrackCrypto/master/" + targetID.lower() + ".csv"
    return pd.read_csv(URL)

for coin in ["Solana", "Bitcoin", "Dogecoin", "Litecoin", "Ethereum", "Cardano", "Chainlink", "Uniswap"]:
    st.subheader(coin)
    if st.checkbox(coin):
        st.write(load_data(coin))
        
# hist_values = np.histogram(
#     data[DATE_COLUMN].dt.hour, bins=24, range=(0, 24))[0]
