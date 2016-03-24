# Issue
Ubuntu Linux 14.04 can not access exFAT flash drive

# Error

```
Error mounting /dev/sdc1 at /media/banana/新加卷: Command-line `mount -t "exfat" -o "uhelper=udisks2,nodev,nosuid,uid=1000,gid=1000,iocharset=utf8,namecase=0,errors=remount-ro,umask=0077" "/dev/sdc1" "/media/banana/新加卷"' exited with non-zero exit status 32: mount: unknown filesystem type 'exfat'
```

# Solutions

```Bash
$ sudo apt-get install exfat-fuse exfat-utils
```