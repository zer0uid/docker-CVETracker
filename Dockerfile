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

# Install required packages [100%]
RUN apt-get update 
RUN apt-get install --assume-yes curl vim wget python3 python3-configobj python3-yaml python3-genshi python3-progressbar git rsync libfile-rsyncp-perl w3m debian-archive-keyring python3-apt python3-requests python3-distro-info apt-utils dpkg-dev

# Configure git-pulls directory, this is where CVE, QA, and Security Tools will reside [100%]
RUN mkdir /root/git-pulls

# Clone the required tools into /git-pulls [100%]
RUN git -C /root/git-pulls clone git://git.launchpad.net/ubuntu-cve-tracker
RUN git -C /root/git-pulls clone git://git.launchpad.net/ubuntu-qa-tools
RUN git -C /root/git-pulls clone git://git.launchpad.net/ubuntu-security-tools

# Set variables for each tool
RUN echo 'export UCT="/root/git-pulls/ubuntu-cve-tracker"' >> /root/.bashrc
RUN echo 'export UST="/root/git-pulls/ubuntu-security-tools"' >> /root/.bashrc
RUN echo 'export UQT="/root/git-pulls/ubuntu-qa-tools"' >> /root/.bashrc

# Pull .conf files from github repo
RUN wget https://raw.githubusercontent.com/zer0uid/docker-CVEanalysis/main/.ubuntu-cve-tracker.conf -P /root/
RUN wget https://raw.githubusercontent.com/zer0uid/docker-CVEanalysis/main/.ubuntu-security-tools.conf -P /root/
RUN ln -s /root/git-pulls/ubuntu-security-tools/build-tools/umt /bin/umt
RUN /root/git-pulls/ubuntu-cve-tracker/scripts/packages-mirror

# Clone security-tracker, this takes awhile
RUN git -C /root/git-pulls clone https://salsa.debian.org/security-tracker-team/security-tracker.git
RUN /root/git-pulls/ubuntu-cve-tracker/scripts/fetch-db database.pickle.bz2
RUN /root/git-pulls/ubuntu-security-tools/build-tools/build-sources-list | sh -c 'cat > /etc/apt/sources.list.d/ubuntu-security.list'
RUN cp /usr/share/keyrings/debian-archive-keyring.gpg /etc/apt/trusted.gpg.d/
RUN apt-get update
RUN echo "....BUILD COMPLETE..."