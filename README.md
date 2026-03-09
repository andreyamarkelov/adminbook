# Book Exercises

This repository contains bash scripts for exercises.

## Structure

The exercises are organized by chapter, with each chapter in its own subdirectory:

```
adminbook/
├── chapter_2/    (5 exercises)  - Basic Linux commands and documentation
├── chapter_3/    (5 exercises)  - Bash scripting fundamentals
├── chapter_4/    (6 exercises)  - User and group management
├── chapter_5/    (5 exercises)  - Disk partitioning and LVM
├── chapter_6/    (6 exercises)  - Filesystems and permissions
├── chapter_7/    (6 exercises)  - System services and processes
├── chapter_8/    (9 exercises)  - Job scheduling and SSH
├── chapter_9/    (10 exercises) - Package management (DNF, RPM, Flatpak)
├── chapter_10/   (14 exercises) - Networking and firewall
└── chapter_11/   (4 exercises)  - SELinux
```

**Total: 70 executable bash scripts**

## Chapter Topics

### Chapter 2: Documentation and Basic Commands
- Man pages, info pages
- Bash aliases
- Find command and pipes
- Vim tutorial

### Chapter 3: Bash Scripting
- Argument processing
- File and directory operations
- Conditional statements and loops
- Test operators

### Chapter 4: User and Group Management
- Creating users and groups
- User modification and deletion
- Password aging policies
- Sudo configuration

### Chapter 5: Disk Management and LVM
- Disk partitioning (fdisk)
- Physical volumes and volume groups
- Logical volumes
- LVM cleanup

### Chapter 6: Filesystems and Storage
- GPT partitioning (parted)
- XFS filesystem
- fstab configuration
- SGID permissions
- Swap files

### Chapter 7: System Management
- Systemd targets
- Journal logs
- Process management (ps, nice, renice)
- TuneD profiles

### Chapter 8: Task Scheduling and Remote Access
- Background jobs
- at command
- Cron jobs
- Time management (timedatectl)
- SSH key generation and configuration

### Chapter 9: Package Management
- DNF operations
- RPM queries
- Repository management
- Flatpak applications

### Chapter 10: Networking
- Network interface configuration
- NetworkManager (nmcli)
- Static and DHCP configurations
- Hostname and DNS management
- Firewall configuration (firewall-cmd)

### Chapter 11: SELinux
- SELinux contexts
- File and port labeling
- SELinux booleans

## Source

Original repository: https://github.com/andreyamarkelov/adminbook
