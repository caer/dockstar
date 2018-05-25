# Dockstar: Darkstar Made Easy
Dockstar lets you configure, build, and deploy a new [Darkstar Server](https://github.com/DarkstarProject/darkstar) with zero effort using Docker.

![Dockstar running on MacOS with Ashita client in a Windows VM](dockstar.png)

# Quick-Start
0. Ensure you have the Bash shell (Mac OS and Linux automatically have this) and have [Docker](https://www.docker.com/get-docker) installed.
1. Run `git clone https://github.com/crahda/dockstar` in a terminal
2. `cd dockstar`
3. `bash build.sh` 
4. `bash start.sh` (Be patient; the first server start has to install MySQL and setup the database. Subsequent starts are much faster)
5. A Darkstar server will now be running at the IP address specified by the `$ZONE_IP` environment variable (defaults to your computer's public IP). Enjoy!

# Configuration
All of the configuration options can be found in the `conf` folder. ***DO NOT*** change any of the values labeled as `DS_USERNAME`, `DS_PASSWORD`, or `DS_SERVERNAME`; these values are automatically replaced whenever the server is rebuilt. When you are satified with your configuration changes, you must re-run `bash build.sh` for the changes to take effect.

## Game Masters
Whenever the Dockstar server is started via `bash start.sh`, it will look for an environment variable called `DS_GMS_LIST`. If this variable exists and contains the names of any characters in the game world, those characters will be automatically promoted to level 5 GMS. 

Here's an example configuration you could perform to make `Crahda` and `Rickie` GMs; player names are separated by commas:

    export DS_GMS_LIST="Crahda,Rickie"

## Zone IP
Whenever the Dockstar server is started via `bash start.sh`, it will automatically configure the Zone IP to be your computers public IP address. To override this with a custom domain or other thing, simply run the following command at your command line, replacing `my.domain.com` with your desired public IP or domain name:

    export ZONE_IP=my.domain.com

# Updating
1. `git pull`
2. `bash build.sh`