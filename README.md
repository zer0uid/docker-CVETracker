# About
Docker image with Ubuntu CVE Tracker, Security Tools, and UMT installed to assist in Ubuntu CVE analysis and triage.
You can find the list of available Ubuntu CVE's that need triaged at https://people.canonical.com/~ubuntu-security/cve/universe.html

### CVE Tools installed & configured

* Ubuntu CVE Tracker
* Ubuntu Security Tools
* Ubuntu QA Tools

## Installation Methods
#### Option 1 - Use github repository
* Use the dockerfile to build image locally <br/>
`git clone https://github.com/zer0uid/docker-CVEanalysis.git` <br />
`cd docker-CVEanalysis` <br/>
`docker build -t docker-CVEanalysis .` <br/>
`docker run --it zer0uid/ubuntu-cveanalysis /bin/bash`

#### Option 2 - Use image from dockerhub
* Use image from Dockerhub (https://hub.docker.com/r/zer0uid/ubuntu-cveanalysis) <br />
`docker pull zer0uid/ubuntu-cveanalysis` <br />
`docker run --it zer0uid/ubuntu-cveanalysis /bin/bash` <br />

## Documentation
