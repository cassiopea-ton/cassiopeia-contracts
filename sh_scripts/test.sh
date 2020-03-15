#!/bin/sh
./sh_scripts/02_create_register.sh
fift -s tests/00_basic_register_tests.fif

fift -s fift_scripts/register-oracle.fif
fift -s tests/01_register_oracle_tests.fif

fift -s fift_scripts/register-provider.fif "some.com" "50" "0" "./build/new-public-oracle"
fift -s tests/02_register_provider_tests.fif
