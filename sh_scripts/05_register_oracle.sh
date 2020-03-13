#!/bin/sh
WALLET_NAME="build/new-wallet-00"
SCRIPT_NAME="register-oracle"
CONTRACT=`fift -s fift_scripts/show-init-addr.fif build/new-register `
USER=`fift -s fift_scripts/show-bouceable-addr.fif $WALLET_NAME`
./lite-client/lite-client -C ./lite-client/config.json -c 'last'
SEQNO=`./lite-client/lite-client -C ./lite-client/config.json -c 'runmethod '$USER' seqno' |  grep 'remote result' | cut -d "[" -f2 | cut -d "]" -f1`
STAKE=`./lite-client/lite-client -C ./lite-client/config.json -c 'runmethod '$CONTRACT' getstake' |  grep 'remote result' | cut -d "[" -f2 | cut -d "]" -f1`

fift -s fift_scripts/$SCRIPT_NAME.fif
./lite-client/lite-client -C ./lite-client/ton-global.config -l null -c 'last'
fift -s fift_scripts/wallet.fif $WALLET_NAME $CONTRACT $SEQNO $STAKE "./build/wallet-query" -B "./build/$SCRIPT_NAME.boc" 2>&1
