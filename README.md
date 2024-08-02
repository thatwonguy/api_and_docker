[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# api_and_docker
demo usage of docker with api 

## How To Use Docker To Make Local Development Easier (alternative to virtual environments)

Docker is a very powerful tool for developing applications that run in the cloud. If you want to get the most out of it, you need to make sure that the way you're running your code locally matches as closely as possible with how it runs in the cloud.

This repo demonstrates usage of docker, using a simple API server in Python as an example.

## Usage

As a first step, install Docker (see: https://www.docker.com) and install the requirements. It will be running in the background as a Daemon and then you are able to use it and check that you have it by typing the following command in your terminal:
```
docker --version
```
<br></br>
> [!NOTE]
> Then the following code is what you would use to install all your packages (typically in a virtual env if you weren't using Docker).

```
pip install -r requirements.txt
```
<br></br>
This is how you run the code locally (without Docker). uvicorn is used to do this (detecting changes in .py files and more if specified in yaml for docker image), you call the `main.py` python file containing the code and the `app` server from fastapi that we are using in our code, `--host 0.0.0.0` is our local host, it is accepting requests on `--port 8080` and it automatically reloads and shows changes everytime we make a change in our localhost with the use of `--reload`:


```
uvicorn main:app --host 0.0.0.0 --port 8080 --reload
```
<br></br>
Build and run the Docker image locally, as follows, by giving it a `-t` tag and specify a name for your docker image, which we call `channel-api` here and the `.` is the current folder directory in terminal this command will be called from. Once it has been built with `build`, you also want to `run` it with the specified `-d` tag in order to detach and give you back your terminal for other uses, specification of port `-p 8080:80`, and the docker image that you built in the previous command which is `channel-api`.

```
docker build -t channel-api .
docker run -d -p 8080:80 channel-api
```
<br></br>
If you decide to make changes to this docker image that you just created with the code above, it will not refresh the code by itself and you need to delete the docker image and make a new one with the new changes. This is a cumbersome issue but this is where you would then use something like <i><u>kubernetes</u></i> or any other number of methods (<i><u>github workflow, bitbucket pipeline, or any other continuous deployment pipeline</u></i>) to handle this container orchestration and update with changes as needed without having to make a new docker image each time.

Another option is using `docker-compose`.
In order to run the example server with docker compose, use the below command. `docker-compose` is the name of the yaml file you have created, `up` is used to updated automatically and finally `--build` is used to build using this yaml file.

```
docker-compose up --build
```

If you use docker compose and you make a minor change in the file, you can now see how everything is updated and the server is restarted automatically. You can use the above command to restart the docker image and server if you CTRL+C and stop it anytime. Make sure to study the contents found inside the `docker-compose.yaml` file and the `Dockerfile`, which is run from top to bottom as if you were typing it in bash terminal. The order of commands makes a difference in how the image gets built.
