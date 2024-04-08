# creates a base image on latest version of python
FROM python:latest

# set the working directory
WORKDIR /app

# install dependencies, typically should separate this out as docker caches this requirements.txt install step 
COPY ./requirements.txt /app
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# copy the scripts to the folder
COPY . /app

# start the server
CMD ["uvicorn","main:app","--host","0.0.0.0","--port","80"]