FROM mcr.microsoft.com/powershell:ubuntu-22.04

RUN apt update
RUN apt install -y  git

WORKDIR /powershai
COPY . .
