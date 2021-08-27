FROM mcr.microsoft.com/dotnet/sdk:5.0.102-1-buster-slim

# Configure man dist and upgrade packages.
RUN mkdir -p /usr/share/man/man1mkdir -p /usr/share/man/man1
RUN apt-get update && apt-get -y dist-upgrade

# Install deps
RUN apt-get install -y \
    locales \
    nodejs \
    openjdk-11-jre \
    libc6-dev \
    libgdiplus \
    build-essential

#Configure locales
RUN touch /usr/share/locale/locale.alias && \
    locale-gen pt_BR pt_BR.UTF-8 pt_BR.UTF-8 && \
    dpkg-reconfigure locales

RUN wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt update && \
    apt install -y dotnet-runtime-2.1

#Install sonar tool.
RUN dotnet tool install --global dotnet-sonarscanner --version 5.0.3

# Cleanup
RUN apt-get clean \
    && apt-get auto-clean \
    && apt-get autoremove

# Configure enviroment
ENV PATH="${PATH}:/root/.dotnet/tools"
ENV LC_ALL="pt-BR.UTF-8"
ENV LANG="pt-BR.UTF-8"
ENV LANGUAGE
