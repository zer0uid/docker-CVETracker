# Set the base
FROM ubuntu:20.04
# Author
MAINTAINER zer0uid@protonmail.com

# Extra metadata
LABEL version="1.0"
LABEL description="Docker image for CVE Analysis"

# Install required packages
RUN apt-get update 
RUN apt-get install --assume-yes curl vim wget python3 python3-configobj python3-yaml python3-genshi python3-progressbar git rsync libfile-rsyncp-perl w3m debian-archive-keyring python3-apt python3-requests python3-distro-info

# Post install cleanup
RUN apt-get -qy autoremove

# Configure git directory
RUN cd $HOME
RUN mkdir ~/git-pulls
RUN cd ~/git-pulls

# Clone the required tools into /git-pulls
RUN git clone git://git.launchpad.net/ubuntu-cve-tracker
RUN git clone git://git.launchpad.net/ubuntu-qa-tools
RUN git clone git://git.launchpad.net/ubuntu-security-tools

# Set variables for each tool
RUN echo 'export UCT="$HOME/git-pulls/ubuntu-cve-tracker"' >> ~/.bashrc
RUN echo 'export UST="$HOME/git-pulls/ubuntu-security-tools"' >> ~/.bashrc
RUN echo 'export UQT="$HOME/git-pulls/ubuntu-qa-tools"' >> ~/.bashrc
SHELL ["/bin/bash", "-c", "source ~/.bashrc"]

# Pull .conf files from github repo
RUN cd $HOME
RUN wget https://raw.githubusercontent.com/zer0uid/docker-CVEanalysis/main/.ubuntu-cve-tracker.conf
RUN wget https://raw.githubusercontent.com/zer0uid/docker-CVEanalysis/main/.ubuntu-security-tools.conf
RUN ln -s $UST/build-tools/umt /bin/umt
RUN cd $UCT;./scripts/packages-mirror
RUN cd /root/git_pulls

# Clone security-tracker, this takes awhile
RUN git clone https://salsa.debian.org/security-tracker-team/security-tracker.git
RUN cd $UCT;./scripts/fetch-db database.pickle.bz2
RUN $UST/build-tools/build-sources-list | sh -c 'cat > /etc/apt/sources.list.d/ubuntu-security.list'
RUN cp /usr/share/keyrings/debian-archive-keyring.gpg /etc/apt/trusted.gpg.d/
RUN cd $HOME
RUN echo "....BUILD COMPLETE..."
