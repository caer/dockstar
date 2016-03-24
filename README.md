# Dockstar: Darkstar Made Easy #
Dockstar is a simple project that leverages the power of Dockers to make setting up and deploying a fully-functional Darkstar server a breeze.

# Installation #
Getting started with Dockstar is very easy, and you only need to meet a few simple requirements:

1. You must be using a Linux system (or have the ability to run a Linux virtual machine).
2. You must have Git installed so that Dockstar can automagically download the Darkstar sources and build itself.
3. You must have Docker installed, for obvious reasons.

Once these requirements are met, simply run the following command in your terminal:

    git clone http://TODO: Dockstar URL

Once that's done, you should have a folder called "dockstar" on your computer. This folder contains a variety of useful things, including:

- The build.sh file, which you will use to build (and re-build) the docker images for Dockstar.
- The config.sh file, which you will use to configure general Dockstar settings before running a build.
- The conf folder, which contains the Darkstar configuration files that you can edit before running a build.
- The start.sh file, which you will use to start the Dockstar server after it's built.
- The stop.sh file, which you will use to stop the Dockstar server after it's built.

You can edit any of these files, but keep in mind that **any changes you make will only apply if you re-build the Docker images by running build.sh**. With that said, you'll want to go ahead and edit the config.sh file and change the ZONE_IP property. Specifically, the ZONE_IP should be set to the same IP address or URL that you use to connect to your Linux machine from the FFXI clients. If it isn't, trouble will ensue!

Once you've updates the ZONE_IP settings, you can feel free to play around with any of the configuration files in the conf/ folder in order to adjust the Dockstar server to your liking. Take care not to change any of the items labeled DS_USERNAME, DS_PASSWORD or DS_SERVERNAME inside the *.conf files; these values will automatically be replaced by the Dockstar scripts when the images are built.

With everything configured, go ahead and build the Dockstar images by running the following command in your terminal from the root of the Dockstar project:

    sudo sh build.sh

This will start the build process; be patient, as it can take anywhere from ten to thirty minutes to complete. Once it's done, you'll have three new Docker images available on your system:

- dockstar-data, which is a simple volume container image that stores all of the persistent data for the server.
- dockstar-db, which is the MySQL database container image that handles running and administrating the database.
- dockstar-server, which is the game server itself and handles running the three Darkstar servers.

At this point, you're ready to try start up Dockstar - just run the command below in your terminal:

    sudo sh start.sh

This will automatically create and start the Dockstar containers. Once the script finishes, you should be able to connect to the Dockstar server using Windower or Ashita using the IP address that you supplied for the ZONE_IP earlier on.

Enjoy!!
