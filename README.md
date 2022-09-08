# acrn-build-environment

### Step 1: Get latest Dockerfile


### Step 2: Build docker image

`docker build acrn-docker-build`

Once completed, the output should display the ID of the image generated. Please copy the same and replace below where `<ID>` is mentioned.

### Step 3: Tag docker image

Please tag the docker image generated in Step 2 by running the following command:

`docker tag <ID> acrn-docker-build:latest`

Please note `acrn-docker-build:latest` is now generated and can be used to run as a container to get an environment to download and build Celadon.

### Step 4: Create workspace directory in HOST OS
`export WORKSPACE=<full-path-to-directory>`

Since WORKSPACE will be used by local user inside the container image, it is important to give full write and execute permissions to all users for this directory.

`chmod -R 777 $WORKSPACE`

### Step 5: Run acrn-docker-build along with volume mount of WORKSPACE

We have the container image, `acrn-docker-build:latest` and workspace directory `$WORKSPACE` ready. Let us use both of them to start the container.

`docker run -it -v $WORKSPACE:/data/ acrn-docker-build:latest /bin/bash`


`cd /data`

