# Build this image with
# sudo docker build -t zer0uid/docker-cveanalysis . | tee docker.output

# Set the base
FROM ubuntu:20.04
# Author
MAINTAINER zer0uid@protonmail.com

# Extra metadata
LABEL version="1.1"
LABEL description="Docker image for CVE Analysis"
SHELL ["/bin/bash", "-c"]
# May need this after testing, which will give a login shell, so .bashrc is sourced for every command
# SHELL ["/bin/bash", "-c", "-l"]

ENV GIT=/root/git-pulls
ENV UCT=$GIT/ubuntu-cve-tracker
ENV UST=$GIT/ubuntu-security-tools

# Install required packages [100%]
RUN apt-get update 
RUN apt-get install --assume-yes git

# Configure git-pulls directory, this is where CVE, QA, and Security Tools will reside [100%]
RUN mkdir $GIT

# Clone the required tools into /git-pulls [100%]
RUN git -C $GIT clone https://salsa.debian.org/security-tracker-team/security-tracker.git
RUN git -C $GIT clone git://git.launchpad.net/ubuntu-cve-tracker
RUN git -C $GIT clone git://git.launchpad.net/ubuntu-qa-tools
RUN git -C $GIT clone git://git.launchpad.net/ubuntu-security-tools

RUN apt-get install --assume-yes curl vim wget python3 python3-configobj \
    python3-yaml python3-genshi python3-progressbar git rsync \
    libfile-rsyncp-perl w3m debian-archive-keyring python3-apt python3-requests \
    python3-distro-info apt-utils dpkg-dev

RUN echo 'export UCT=$UCT' >> /root/.bashrc
RUN echo 'export UST=$UST' >> /root/.bashrc
RUN echo 'export UQT="$GIT/ubuntu-qa-tools"' >> /root/.bashrc

# Pull .conf files from github repo
COPY .ubuntu-cve-tracker.conf /root/
COPY .ubuntu-security-tools.conf /root/
RUN ln -s $UST/build-tools/umt /bin/umt


RUN $UST/build-tools/build-sources-list | sh -c 'cat > /etc/apt/sources.list.d/ubuntu-security.list'
RUN cp /usr/share/keyrings/debian-archive-keyring.gpg /etc/apt/trusted.gpg.d/

RUN apt-get update
RUN echo "....BUILD COMPLETE..."
