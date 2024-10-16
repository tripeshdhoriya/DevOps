#######BlueCardinal Image create steps##########

- Download desktop deocker for windows https://docs.docker.com/desktop/install/windows-install/
- For creating images for server
	-  Keep place DockerfileServer file on Bluecardinal server folder.
	-  make sure jre shold be compitable with Linux 
	-  Chanage according jre path in start-server.sh if required
	-  If all things are looks ready then rung DockerfileServer file on powershell from existing path.
	-  keep DockerfileServer over the path as like PATH:C:\SigmaStream\Bluecardinal\bluecardinal-server\DockerfileServer
	-  Run command to build Yh-server image - docker build -t bluecadinal -f .\DockerfileServer .  (for server) 
	-  Check on docker images or container section where new images and container will be create	
- For export image - docker save -o bluecardinal.tar bluecardinal:latest   (docker save -o <output_file>.tar <local_image>:<tag>




#################BlueCardinal setup with docekr image###################

1) Download Docker Desktop for Windows from https://docs.docker.com/desktop/install/windows-install/.
2) Extract the "BlueCardinal.zip" file, which you will obtain from SigmaStream.
3) After extracting the .zip file, you will find the following items:
		- AppData
		- docker-compose.yml
		- BlueCardinal.tar 
4) Now we need to import the Docker images into Docker containers.
5) Open PowerShell at the location of the image files and run the following commands to import them:
		- For the server: docker load -i BlueCardinal.tar
6) Once the image loading is complete, both images will appear in the Docker image section.
7)In the same composed file we ahve asloe intruct to setup cassandra as well as postgresql
	- For postgresql and cassandra we have already mapped respectvied directory in the composed. so we need to created directoy and palces file as it is which we have mention in composed.
	- if you have buluecardial bunlde then in the bundle all file are already place on it you just need to confirm it.
	- Postgresql database automatic restore and creatd user with database as mention in config.properties
	- For Cassandra we just need to mannualy create keyspace using below command:
		-CREATE KEYSPACE bluecardinal WITH replication = {'class': 'NetworkTopologyStrategy', 'datacenter1': '1'}  AND durable_writes = true;


8) Next, we need to run the composed file.
		- Open PowerShell at the location of the Docker Compose file.
		- Make sure all the files are present in this location.
8) After verifying all the items, run the composed file using the following command: docker-compose up -d
9) When starting the Docker Compose file, you may encounter an error in the AppData/logs directory, which reads "Failed. Invalid License Key!" To resolve this error, you need to provide a public key to the    SigmaStream Team, which you can obtain from the AppData/config/licenseKey.txt file.
10) The SigmaStream Team will generate a license key and provide it to you. After receiving this license key, you need to replace the existing license key in the config.properties file located in the AppData/config directory.
11)Now, start your container, and the server will launch without any errors.