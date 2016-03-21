# Environment:
* Ubuntu Linux 14.04.4LTS x86_64
*

# After installing Ubuntu Linux system iand login:
Install some necessary packages like git, gcc etc.

## Update apt-get repository:
Config your proxy if you use a proxy server, **System Settings** -- ** Network**
```Bash
$ sudo apt-get update
```

## Install basic guild chain tools:
```Bash
$ sudo apt-get install vim build-essential git tree
```

## Install Open-SSH service to login remotely
```Bash
$ sudo apt-get install openssh-server
```

Check if the openssh server is running
```Bash
$ sudo service ssh status
[sudo] password for apple: 
.ssh start/running, process 6389
```

### Install Python3.5 and IPython
```Bash


```