import streamlit as st
import pandas as pd


for coin in ["solana", "bitcoin", "dogecoin", "litecoint", "ethereum", "cardano", "chainlink", "uniswap"]:
    if st.checkbox('Show ' + coin):
        st.subheader(coin)
        st.write(pd.read_csv(
            "https://raw.githubusercontent.com/dfinke/TrackCrypto/master/" + coin + ".csv"))
