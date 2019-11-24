---
title: Introduction
weight: 10
disableToc: true
---

![Bash logo](/bash-notes/en/basics/introduction/images/bash-logo-web.png)

[The GNU Bourne-Again SHell](https://www.gnu.org/software/bash/) is a very popular shell that combines functionalities for both programming and interactive use.

### Other shells
* [C shell - `csh`](https://en.wikipedia.org/wiki/C_shell)
* [KornShell - `ksh`](https://en.wikipedia.org/wiki/KornShell)
* [Bourne shell - `sh`](https://en.wikipedia.org/wiki/Bourne_shell)
* [Z shell - `zsh`](https://en.wikipedia.org/wiki/Z_shell) with [Oh-my-zsh](https://ohmyz.sh/)
* [Debian Almquist shell - `dash`](https://en.wikipedia.org/wiki/Almquist_shell)


## What is a 'shell' then?
It's a program that receives input from the keyboard and forwards them to the operating system. It was the first kind of user interface used.

## What is a 'terminal [emulator]'?
Nowadays, most operating systems provide a Graphical User Interface (GUI). A terminal emulator is a program that lets you interact with a shell. Examples include: gnome-terminal, terminator.

## Starting bash

Assumming you're in an operating system that has a GUI, just open your favorite terminal emulator and type:
```bash
$ bash
```

Printing the version of bash:
```bash
$ bash --version
GNU bash, version 4.3.48(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

## Modes of execution

In bash you can either type commands and run them immediately (interactive), or place them in a file and then run as a batch of commands (also known as a bash script)

### Interactive

Print the working directory:
```bash
$ pwd
/home/vagrant
```
list the files and directories in current directory:
```bash
$ ls
```

### Non-interactive (bash script)

Create a file (named `myfile`) and place the following content in it:
```
pwd
ls
```

Run that file using bash
```bash
$ bash myfile
/home/vagrant
myfile
```

![Magic](/bash-notes/en/basics/introduction/images/magic.gif?classes=shadow)
