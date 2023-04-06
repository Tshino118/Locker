# Launch torch container
Launch ```bash setup.sh`` in prompt.

## Edit setting
Please edit setting file.
This file include variable using following shell scripts.

## setup.sh
Pulling base image, Build Dockerfile and Launch docker container.

## docker_setup.sh
Pulling base images.
If you need to change base image that please edit Dockerfile.
### Variables
```
base_image
```

## repository_setup.sh
Building Docker repositroy.
### Variables
```
repository_name
repository_version
```

## launch_container.sh
Launch Docker interactive container.
### Variables
```
container_name
container_run_arg
````

