step1: Clone repository to the  machine
git clone https://github.com/infracloudio/csvserver.git

go to the csvserver repo and solution folder

cd csvserver/solution

Step 2: Run the container in the background and check if it's running
First, pull and run the infracloudio/csvserver:latest container.

# Pull the latest image
docker pull infracloudio/csvserver:latest

# Run the container in the background
docker run -d --name csvserver infracloudio/csvserver:latest

# Check the status of the container
docker ps -a | grep csvserver

#If the container is not running, check the logs to find the reason.

docker logs csvserver

#Based on the logs, we may find an error related to the missing input file:

could not open file: open /csvserver/inputdata: no such file or directory

Step 3: Write the gencsv.sh script
Created a script gencsv.sh that generates the required inputFile.

#Make the script executable:
chmod +x gencsv.sh

#Run the script by passing parameters to generate the inputFile:
./gencsv.sh 2 8

Step 4: Run the container with the generated inputFile
Run the container again with the generated inputFile mounted:

docker run -d --name csvserver -v $(pwd)/inputFile:/csvserver/inputdata infracloudio/csvserver:latest

# Check the status
docker ps | grep csvserver

Step 5: Get shell access to the container and find the port
Get shell access to the running container and find the port the application is listening on:

docker exec -it csvserver /bin/sh

# Inside the container, find the port
netstat -tuln
we should find the application listening on port 9393

Step 6: Run the container and make sure it's accessible
Stop and remove the running container:

docker stop csvserver
docker rm csvserver

#Run the container with the environment variable set:
docker run -d --name csvserver -v $(pwd)/inputFile:/csvserver/inputdata -p 9393:9300 -e CSVSERVER_BORDER="Orange" infracloudio/csvserver:latest

#Verify that the application is accessible on the host at http://localhost:9393 and has the welcome note with an orange border:

# Check if the container is running
docker ps | grep csvserver

# Access the application
curl http://localhost:9393

application is now running with correct environment settings and accessible at http://localhost:9393. The data from inputFile is  displayed, and the welcome note is having an orange border.

