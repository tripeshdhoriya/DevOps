#psql -U adempiere -d KFSeed -f /dump/KFSeed_Fresh.sql
pg_restore --username "adempiere" --dbname "KFSeed" --role "adempiere" --verbose "/dump/KFSeed_Fresh.sql"