## Setup

- [ ] Fork the repo
- [ ] Enable the GitHub Action
- [ ] Done

The action runs on a daily CRON at 4am and updates the coins.xlsx file with a new worksheet

## Coins.txt

Add the crypto symbol to the file, check it in, and the action will trigger and update the worksheet.

## The REST API

The [coingecko](https://www.coingecko.com/en/api) provides a REST API for all of the data we need.

## Excel

The PowerShell Excel module is used to read and write the Excel files.