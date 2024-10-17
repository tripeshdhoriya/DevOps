Hummingbird Setup with Docker Image:

1.Download Docker Desktop for Windows from https://docs.docker.com/desktop/install/windows-install/.
2.Extract the "SigmaStream.zip" file, which you will obtain from SigmaStream.
3.After extracting the .zip file, you will find the following items:
	- HBData
		- Logs
		- idempiere-server.sh
		- hummingbird.properties
	- docker-compose.yml
	- hummingbird.tar
4.Now we need to import the Docker images into Docker containers.
5.Open PowerShell/Terminal at the location of the image files and run the following commands to import them:
	- docker load -i hummingbird.tar
6.Once the image loading is complete, images will appear in the Docker image section.
7.Next, we need to run the composed file.
	- Open PowerShell/Terminal at the location of the Docker Compose file.
	- Make sure all the files are present in this location, and also check the postgres directory for the presence of the KFSeed.sql file; otherwise, the database will not be restored.
8.After verifying all the items, run the composed file using the following command:
	- docker-compose up -d
9.Check the logs to ensure that all items are starting properly. Now, you can access both URLs in your browser: https://IP-Address:7070


For Image Creation:

1.For Image creation, you will get your "dockerfileserver" file. In this file, you have written which you will need to copy items in your image.
	- Run "dockerfileserver" file using the below command:
		- docker build -t hummingbird -f .\DockerfileServer .
		
		Note - Before running the dockerfileserver file, you need to place some files which are as follows for idempiere:
		
		- idempiere-server.sh
		- docker-entrypoint.sh
		- idempiere-server.zip
2.After running the "dockerfileserver" file if not getting any error, you will get the image "hummingbird" in the image section.
3.For Exporting the image into tar format run as below command:
		- docker save -o hummingbird.tar hummingbird:latest