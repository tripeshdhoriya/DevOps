
psql -U sigmastream -d yellowhammer -f /docker-entrypoint-initdb.d/yh_dump.sql && psql -U adempiere -d KFSeed -f /docker-entrypoint-initdb.d/KFSeed.sql