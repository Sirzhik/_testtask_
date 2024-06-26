@echo off
set token=7421484090:AAFh3mv7YDFEbH7lEcF2tsoYOTLp04tnseI
set wl_path=user_lists\whitelist.txt
set al_path=user_lists\adminlist.txt
set debug=true

set host=127.0.0.1
set user=postgres
set SQL_password=root
set db_name=stock

python aiotest.py
