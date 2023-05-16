#!/usr/bin/python2.4
#
import psycopg2
try:
    db = psycopg2.connect("postgresql://<app>:<pwd>@<host>:<port>/<db>")
except:
    exit(1)

exit(0)
