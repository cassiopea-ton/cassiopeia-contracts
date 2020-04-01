#!/bin/sh
WALLET_NAME="build/new-wallet"
SCRIPT_NAME="register-provider"
# CONTRACT=`fift -s fift_scripts/show-init-addr.fif build/new-register `
CONTRACT="kf8gYJtGzU_mVLcvjs3d6Yb2SE3BPnN_0QmzbKc7d7agmLro"
USER=`fift -s fift_scripts/show-bouceable-addr.fif $WALLET_NAME`
./lite-client/lite-client -C ./lite-client/config.json -c 'last'
SEQNO=`./lite-client/lite-client -C ./lite-client/config.json -c 'runmethod '$USER' seqno' |  grep 'remote result' | cut -d "[" -f2 | cut -d "]" -f1`
STAKE=`./lite-client/lite-client -C ./lite-client/config.json -c 'runmethod '$CONTRACT' getstake' |  grep 'remote result' | cut -d "[" -f2 | cut -d "]" -f1`

fift -s fift_scripts/$SCRIPT_NAME.fif "sdsds.com" 50 0 "build/new-register"
./lite-client/lite-client -C ./lite-client/ton-global.config -l /dev/null -c 'last'
fift -s fift_scripts/wallet.fif $WALLET_NAME $CONTRACT $SEQNO 0.2 "./build/wallet-query" -B "./build/$SCRIPT_NAME.boc"
