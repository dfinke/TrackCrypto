import streamlit as st
import pandas as pd
import numpy as np

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
    data = load_data(coin)
    st.subheader(coin)
    # st.bar_chart(hist_values)
    if st.checkbox('show ' + coin):
        st.write(data)
        
# hist_values = np.histogram(
#     data[DATE_COLUMN].dt.hour, bins=24, range=(0, 24))[0]
