CREATE USER rtv WITH PASSWORD 'Init@123!';
CREATE DATABASE "rtv" OWNER rtv;
GRANT ALL PRIVILEGES ON DATABASE "rtv" TO rtv;


\! pg_restore -U rtv -d rtv /docker-entrypoint-initdb.d/rtv.dump