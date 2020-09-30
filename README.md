# binwalk
Dockerfile for assemble binwalk on Ubuntu 18.04

# How to use?

Install Docker on your OS from official site

Please clone official repositories of Binwalk https://github.com/ReFirmLabs/binwalk
```
git clone https://github.com/ReFirmLabs/binwalk.git

```
Copy the Dockerfle in to the folder reposirory

Run ``` docker build -t <user>/<name>:<tag> . ```

Run ``` docker run -it <user>/<name>:<tag> /bin/bash ```

Run ``` binwalk --help ```

```docker pull udawpk/binwalk```
