#!/bin/sh
WALLET_NAME="build/new-wallet-00"
CONTRACT=`fift -s fift_scripts/show-init-addr.fif build/new-public-oracle `
USER=`fift -s fift_scripts/show-bouceable-addr.fif $WALLET_NAME`
./lite-client/lite-client -C ./lite-client/config.json -c 'last'
SEQNO=`./lite-client/lite-client -C ./lite-client/config.json -c 'runmethod '$USER' seqno' 2>&1 |  grep result | cut -d "[" -f2 | cut -d "]" -f1`
SEQNO=`echo $SEQNO | cut -d' ' -f1`

fift -s fift_scripts/wallet.fif $WALLET_NAME $CONTRACT $SEQNO 0.5 "./build/wallet-query"
./lite-client/lite-client -C ./lite-client/config.json -c 'last'
./lite-client/lite-client -C ./lite-client/config.json -c 'sendfile ./build/wallet-query.boc'
sleep 5
./lite-client/lite-client -C ./lite-client/config.json -c 'last'
./lite-client/lite-client -C ./lite-client/config.json -c 'sendfile ./build/new-public-oracle-query.boc'