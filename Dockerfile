FROM ubuntu:20.04
MAINTAINER zer0uid@protonmail.com

RUN apt-get update 
RUN apt-get install -y curl vim wget python3 python3-configobj python3-yaml python3-genshi python3-progressbar git rsync libfile-rsyncp-perl w3m debian-archive-keyring python3-apt python3-requests python3-distro-info
RUN mkdir ~/git-pulls
RUN cd ~/git-pulls
RUN git clone https://git.launchpad.net/ubuntu-cve-tracker
RUN git clone https://git.launchpad.net/ubuntu-qa-tools
RUN git clone https://git.launchpad.net/ubuntu-security-tools
RUN echo 'export UCT="$HOME/git-pulls/ubuntu-cve-tracker"' >> ~/.bashrc
RUN echo 'export UST="$HOME/git-pulls/ubuntu-security-tools"' >> ~/.bashrc
RUN echo 'export UQT="$HOME/git-pulls/ubuntu-qa-tools"' >> ~/.bashrc
RUN source ~/.bashrc
RUN cd $HOME
RUN wget https://raw.githubusercontent.com/zer0uid/docker-CVETracker/main/.ubuntu-cve-tracker.conf
RUN wget https://raw.githubusercontent.com/zer0uid/docker-CVETracker/main/.ubuntu-security-tools.conf
RUN ln -s $UST/build-tools/umt /bin/umt
RUN cd $UCT;./scripts/packages-mirror
RUN cd ~/git_pulls
RUN git clone https://salsa.debian.org/security-tracker-team/security-tracker.git
RUN cd $UCT; ./scripts/fetch-db database.pickle.bz2
RUN $UST/build-tools/build-sources-list | sh -c 'cat > /etc/apt/sources.list.d/ubuntu-security.list'
RUN cp /usr/share/keyrings/debian-archive-keyring.gpg /etc/apt/trusted.gpg.d/
