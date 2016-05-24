# openelis-contrib-docker
Docker containers for [openELIS] (https://github.com/jsibley/openelisglobal-core)

This repository contains the necessary infrastructure code and related resources required to compose and run Docker containers that start an instance of the [openELIS] (https://github.com/jsibley/openelisglobal-core)

### Prerequisites

Make sure you have [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/install/) installed.

## Access

To log into OpenElis, use the following details:

* **Host**: `DOCKER_HOST:8080/openElisGlobal`
* **username**: admin
* **Pass**: adminADMIN!

### Setup

Start by cloning this repository:

````
git clone https://github.com/esaude/openelis-contrib-docker.git
````
Enter the directory and build the images:

````
cd openelis-contrib-docker
docker-compose build

````
Once the build is complete, you can run the openelis by executing the following:
````
docker-compose up
````

## License

MPL-2.0