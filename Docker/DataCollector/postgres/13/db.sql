CREATE USER sigmastream WITH PASSWORD 'SigmaStream#1';
CREATE DATABASE "yellowhammer" OWNER sigmastream;
GRANT ALL PRIVILEGES ON DATABASE "yellowhammer" TO sigmastream;


CREATE USER adempiere WITH PASSWORD 'adempiere';
CREATE DATABASE "KFSeed" OWNER adempiere;
GRANT ALL PRIVILEGES ON DATABASE "KFSeed" TO adempiere;
