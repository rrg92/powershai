FROM mcr.microsoft.com/powershell:ubuntu-22.04

RUN apt update
RUN apt install -y  git

RUN pwsh -Command "Install-Module Pester; Install-Module platyPS"

WORKDIR /powershai
COPY . .
