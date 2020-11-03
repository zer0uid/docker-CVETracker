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
`sudo docker build -t zer0uid/docker-cveanalysis .` <br/>
`sudo docker run -it zer0uid/docker-cveanalysis bash`

#### Option 2 - Use image from dockerhub
* Use image from Dockerhub (https://hub.docker.com/r/zer0uid/ubuntu-cveanalysis) <br />
`docker pull zer0uid/ubuntu-cveanalysis` <br />
`docker run -it zer0uid/ubuntu-cveanalysis /bin/bash` <br />

## Documentation

1. Use CVE Tracker to find CVE's that "needs triaged" for the following versions:

**CVE Tracker URL
https://people.canonical.com/~ubuntu-security/cve/universe.html

2. What to look for?
CVE's that impact versions: Xenial, Bionic, Focal, and Gorilla
- Disregard Precise and Trusty
- Skipy anything related to the kernel

3. Run the command to find the available versions in Ubuntu<br />
`$> umt search "packag_name_without_quotes"`

4. Open the CVE file to triage<br />
`$> cd UCT`<br />
`$> vim active/CVE-2020-11025 (example, changed as needed)`

5. Update CVE File (Available Status: "needs-triage" "needed" "not-affected" "DNE")
- Change "needs-triage" to "needed" or "not-affected"
- If "not-affected", include patched version or "(code not present)"
    Example: "not-affected" (3.2.1-4)
- Save file

6. Traige 5-10 CVE's and then commit your changes for review

7. Commit changes via git<br />
`$> cd $UCT`<br />
`$> git add .`<br />
`$> git commit`<br />
- Text editor opens, add message (example: "CVE triage of Wordpress CVE's")

8. Submit your patch file
-Email patch file to mike.salvatore@canoncial.com & clairesouthwell@gmail.com

* Additional Git commands:<br />
    `$> git add #stage new changes`<br />
   ` $> git format-patch -1 #creates a patch file for your last 1 commit`<br />
    `$> git status #shows which files have been modified`<br />
   ` $> git diff #shows your changes`<br />
    `$> git commit --amend --no-edit #edit last commit without changing message`

# Configuring your identiy for git<br />
`$> git config --global user.email "you@example.com"`<br />
`$> git config --gobal user.name "your name"`
