# Linux File Structure

## Basic Structure

Some common and important directories in the linux file system

### /

The root of the system, contains subdirectories

### /etc

Should only contain text files, which are system configurations. Some files of interest:

* passwd - defines users; this is where all the information for users is defined
* fstab - defines disk drives; contains all the drives that get mounted when the system boots
* hosts - lists the network hosts that are intrinsically known to the system
* init.d - contains scripts that start system processes, typically at the system booting

### /bin, /usr/bin

contains most of the programs for the system. `/bin` contains programs required for the system to operate, and `/usr/bin` contains programs for the systems users

### /sbin, /usr/bin

contains programs for the system admin, usually for use by the superuser

### /usr

contains a variety of things to support user applications

* /usr/share/X11 - Support files for the X Window system
* /usr/share/dict - Dictionaries for the spelling checker. Bet you didn't know that Linux had a spelling checker. See `look` and `aspell`.
* /usr/share/doc - Various documentation files in a variety of formats.
* /usr/share/man - The man pages are kept here (manuals).
* /usr/src - Source code files. If you installed the kernel source code package, you will find the entire Linux kernel source code here.

### /usr/local

contains installed software; meant for files and packages that are not part of the official system distribution (those would be found in `/usr/bin`). Most of the time, these installations are found in `/usr/local/bin`

### /var

contains files that change as the system runs, such as logs (`/var/log`) and files that are queued up for a process (`/var/spool`)

### /lib

contains shared libraries

### /home

This is where users keep there files, and in general this is the only place they can write files to (excluding the system admin, aka superuser)

### /root

the super users home directory

### /tmp

where programs write their temporary files

### /dev

doesn't contain files in the usual sense, but rather contains the drives that are known to the system. Linux essentially views drives as files, so they can be read from and or written to.

### /proc

Is a virtual directory, and is essentially a peephole into the running kernel. Gives information about running proccesses, the cpu, etc.

### /media, /mnt

used for mount points, and is populated based on what the system sees in `/etc/fstab`, which describes which device is mounted at which mount point in the directory tree. Also takes care of "temporary" mounts, such as CDs or thumb drives. `/mnt` provides a place to mount temporary devices on linux systems that require manually mounting all devices, so you'll often see things like `/mnt/floppy` or `/mnt/cdrom` on these systems. Use the `mount` command to see what devices are mounted on your system.

## Symbolic Links

Symbolic links can be used to lead a file name to a different file. When using the ls command, these files will show up as `symbolic_name -> real_name`. This is useful for programs that are looking for a specific file, but whose value may want to be changed. The linux kernel is a good example; programs will almost always be looking for `vmlinuz` for the kernel, but it can be symbolically linked and changed as desired. Symbolic links can be created with the `ln` (link) command

















