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

for coin in ["Solana", "Bitcoin", "Ethereum", "Dogecoin", "Litecoin", "Cardano", "Chainlink", "Uniswap"]:
    data = load_data(coin)
    
    st.subheader(coin)
    chart_data = pd.DataFrame(
        data.current_price
    )

    st.line_chart(chart_data)

    if st.checkbox('show ' + coin + ' data'):
        st.write(data)