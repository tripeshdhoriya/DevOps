YellowHammer Setup with docker image.

1) Download Docker Desktop for Windows from https://docs.docker.com/desktop/install/windows-install/.
2) Extract the "SigmaStream.zip" file, which you will obtain from SigmaStream.
3) After extracting the .zip file, you will find the following items:
		- AppData
		- docker-compose.yml
		- postgres.env
		- mongo
		- postgres
		- yh-client.tar (Docker image for YH-webclient)
		- yh-server.tar (Docker image for YH-server)
4) Now we need to import the Docker images into Docker containers.
5) Open PowerShell at the location of the image files and run the following commands to import them:
		- For the server: docker load -i yh-server.tar
		- For the web client: docker load -i yh-client.tar
6) Once the image loading is complete, both images will appear in the Docker image section.
7) Next, we need to run the composed file.
		- Open PowerShell at the location of the Docker Compose file.
		- Make sure all the files are present in this location, and also check the postgres directory for the presence of the yh_dump.sql file; otherwise, the database will not be restored.
8) After verifying all the items, run the composed file using the following command: docker-compose up -d
9) Check the logs to ensure that all items are starting properly. Now, you can access both URLs in your browser: https://IP-Address:8081 (YH-Server) and https://IP:Address://8082 (YH-webclient).
10) When logging into YH-webclient, you will encounter a license_key error. To resolve this, you need to generate a public key for your machine using the instructions provided during the YH-client login process.
	- For the login into Yh-client 
		Server URL - https://IP-Address:8081
		Username - RigAdmin
		Password - SigmaStream#1
11) Send the generated public key to support@sigmastrem.com, and you will receive a license_key from SigmaStream.
12) Set this license_key in D:\SigmaStream\AppData\config-ext.properties file and restart the server composed file.