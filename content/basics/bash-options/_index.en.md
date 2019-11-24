---
title: Bash options
weight: 30
---

Running a bash script has some interesting options that are worth mentioning. Let's explore them here.

In order to prepare for this, let's create the plain file `script1` with the following content in it:
```bash
echo 'process started'
ls non-existing
sleep 10 #time in seconds
touch somefile
ls -l somefile
echo 'process ended'
```

## Check for syntax validity

```bash
$ bash -n script1
```
When nothing is printed, the syntax is fine

## Output commands as they're being read

Using verbose flag:
```bash
$ bash -v script1
echo 'process started'
process started
ls non-existing
ls: cannot access 'non-existing': No such file or directory
sleep 10 #time in seconds
touch somefile
ls -l somefile
-rw-rw-r-- 1 vagrant vagrant 0 Nov 24 23:06 somefile
echo 'process ended'
process ended
```
{{% notice note %}}
Notice how the comment is also being printed
{{% /notice %}}

Using the `-x` flag:
```bash
$ bash -x script1
+ echo 'process started'
process started
+ ls non-existing
ls: cannot access 'non-existing': No such file or directory
+ sleep 10
+ touch somefile
+ ls -l somefile
-rw-rw-r-- 1 vagrant vagrant 0 Nov 24 23:08 somefile
+ echo 'process ended'
process ended
```
It shows every line being executed. Also arguably more readable than a plain `-v`.
{{% notice note %}}
Notice how the comment is being ignored
{{% /notice %}}

