# Dockstar: Darkstar Made Easy
Dockstar lets you configure, build, and deploy a new Darkstar server with zero effort.

# Quick-Start
0. Ensure your system supports the BASH shell (Mac OS and Linux automatically have this)
1. Run `git clone https://github.com/crahda/dockstar` in a terminal
2. `cd dockstar`
3. `bash build.sh` (wait a very long time)
4. `bash start.sh` (wait a moderate amount of time the first time)
5. A Darkstar server will now be running at your computer's public IP address. Enjoy!

# Configuration
The root project folder contains a variety of helpful things:

- The build.sh file, which you will use to build (and re-build) the docker images for Dockstar.
- The config.sh file, which you will use to configure general Dockstar settings before running a build.
- The conf folder, which contains the Darkstar configuration files that you can edit before running a build.
- The start.sh file, which you will use to start the Dockstar server after it's built.
- The stop.sh file, which you will use to stop the Dockstar server after it's built.

You can feel free to play around with any of the configuration files in the conf/ folder in order to adjust the Dockstar server to your liking. Take care not to change any of the items labeled DS_USERNAME, DS_PASSWORD or DS_SERVERNAME inside the `.conf` files; these values will automatically be replaced by the Dockstar scripts when the images are built. Whenever you make a change to any of the configuration files, you ***must*** re-run `bash build.sh` for those changes to take effect.

## Zone IP
Whenever you start the Dockstar server via `bash start.sh`, it will automatically configure the Zone IP to be your computers public IP address. To override this with a custom domain or other thing, simply run the following command at your command line, replacing `my.domain.com` with your desired public IP:

    export ZONE_IP=my.domain.com

# Updating
1. `git pull`
2. `bash build.sh`