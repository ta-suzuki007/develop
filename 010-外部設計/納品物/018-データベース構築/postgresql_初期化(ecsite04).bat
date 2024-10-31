
set PGPASSWORD=postgres

psql -U postgres -f postgresql_init_ecsite.sql
psql -U postgres -d ecsite -f postgresql_ecsite_data04.sql

pause
