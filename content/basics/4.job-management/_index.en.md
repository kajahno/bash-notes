---
title: Job Management
weight: 25
---

When running programs in bash, it's possible to do it in a 'detached' mode. That is, sending the job to the background and continuing using the terminal

In order to prepare for this, let's create the plain file `long-time` with the following content in it:
```bash
echo 'process started'
sleep 60 #time in seconds
echo 'process ended'
```

You can run this file by doing:
```bash
$ bash long-time
```
The downside is that it will take around 60 seconds, time in which the terminal will be busy and cannot be used.

## Send jobs to the background

Just append an ampersand to the end of the command:
```bash
$ bash long-time &
[1] 1718
```
The good thing is that now we can keep using the terminal since the job is executing in the background. This can be confirmed by running:
```bash
$ jobs
[1]+  Running                 bash long-time &
```

Something you'll notice is that even though the program is running in the background, the output is being redirected to the terminal. Of course, we can redirect it as well.

Similarly we can end or kill jobs that are in the background, as follows:
```bash
$ kill %1
$
[1]+  Terminated              bash long-time
```
