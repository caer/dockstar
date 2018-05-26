# Dockstar: Darkstar Made Easy
Dockstar lets you configure, build, and deploy a new [Darkstar Server](https://github.com/DarkstarProject/darkstar) with zero effort using Docker.

![Dockstar running on MacOS with Ashita client in a Windows VM](dockstar.png)

# Quick-Start
0. Ensure you have the Bash shell (Mac OS and Linux automatically have this) and have [Docker](https://www.docker.com/get-docker) installed.
1. Run `git clone https://github.com/crahda/dockstar` in a terminal
2. `cd dockstar`
3. `bash build.sh` 
4. `bash start.sh` (Be patient; the first server start has to install MySQL and setup the database. Subsequent starts are much faster)
5. A Darkstar server will now be running at the IP address specified by the `$DRK_ZONE_IP` environment variable (defaults to your computer's public IP). Enjoy!

# Configuration
All of the configuration files can be found in the `config` folder. Files that end in `.drk` will be automatically loaded as their corresponding `.conf` files when the server starts.

Whatever you do, ***DO NOT*** change any of the all-caps strings that start with `DRK_` in the `.drk` files; these are automatically replaced with appropriate values when the server starts.

## Game Masters
Whenever the Dockstar server is started via `bash start.sh`, it will look for an environment variable called `DRK_GMS_LIST`. If this variable exists and contains the names of any characters in the game world, those characters will be automatically promoted to level 5 GMS. 

Here's an example configuration you could perform to make `Crahda` and `Rickie` GMs; player names are separated by commas:

    export DRK_GMS_LIST="Crahda,Rickie"

## Zone IP
Whenever the Dockstar server is started via `bash start.sh`, it will automatically configure the Zone IP to be your computers public IP address. To override this with a custom domain or other thing, simply run the following command at your command line, replacing `my.domain.com` with your desired public IP or domain name:

    export DRK_ZONE_IP=my.domain.com