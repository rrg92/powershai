FROM mcr.microsoft.com/powershell:ubuntu-22.04

RUN apt update
RUN apt install -y  git

RUN pwsh -NonInteractive -Command "Install-Module -Force Pester;Install-Module -Force PlatyPS"

WORKDIR /powershai
COPY . .
