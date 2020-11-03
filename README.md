# About
Docker image with Ubuntu CVE Tracker, Security Tools, and UMT installed to assist in Ubuntu CVE analysis and triage.
You can find the list of available Ubuntu CVE's that need triaged at https://people.canonical.com/~ubuntu-security/cve/universe.html

## docker-CVEanalysis
Project to create a Docker container with the following tools:

* Ubuntu CVE Tracker
* Ubuntu Security Tools
* Ubuntu QA Tools

## Installation Methods
* Use the dockerfile to build image locally
`docker build -t zer0uid/docker-cveanalysis .`
* Download the image from Dockerhub via https://hub.docker.com/r/zer0uid/ubuntu-cveanalysis
