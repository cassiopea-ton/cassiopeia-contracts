#!/bin/sh
./sh_scripts/01_create_public_oracle.sh
./sh_scripts/02_create_register.sh

fift -s tests/00_basic_register_tests.fif

fift -s fift_scripts/register-oracle.fif
fift -s tests/01_register_oracle_tests.fif

fift -s fift_scripts/register-provider.fif "some.com" "50" "0" "./build/new-public-oracle"
func -P -o build/public-oracle-code.fif contracts/stdlib.fc contracts/public-oracle-code.fc
fift -s fift_scripts/new-public-oracle.fif "./build/new-public-oracle1"
fift -s fift_scripts/register-provider.fif "pua" "570" "0" "./build/new-public-oracle1" "./build/register-provider1"
fift -s tests/02_register_provider_tests.fif

fift -s fift_scripts/send-int-data.fif "some.com" "50" "0" 
fift -s tests/03_send_int_data_tests.fif

fift -s fift_scripts/request-data.fif "some.com" "./build/new-wallet" 
fift -s tests/04_request_data_tests.fif

fift -s tests/05_pay_tests.fif

fift -s tests/06_punish_tests.fif

fift -s fift_scripts/withdraw.fif "0.000000050" 
fift -s tests/07_withdraw_tests.fif

fift -s tests/08_send_oracle_tests.fif

fift -s tests/09_tick_oracle_tests.fif
fift -s tests/10_request_oracle_tests.fif