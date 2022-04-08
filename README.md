Tried on Ubuntu 20.04.1 LTS (Focal Fossa)

 ## Setup
 1. Install Docker (https://docs.docker.com/get-docker/).
 2. Run `docker-compose up` in the root folder of this repo (might need sudo depending on how you installed and configured docker and its associated user groups).

 ## Interacting with the containers
 Once the system is running you can use the following command to get an interactive shell in the docker containers:
 ```
 docker exec -i -t <component_name> bash
 ```
The component names can be autocompleted.

**TODO:** short explanation on main script?
