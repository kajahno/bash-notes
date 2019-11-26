---
title: Decision Making
weight: 35
---

Making decisions help our scripts to have better flow control and add additionally robustness and avoid repetition.

## Inline syntax

This syntax is composed of two operators: and (`&&`) and or `||`

#### **And** (`&&`) case

Run a command and run another one if the former was successful:
```bash
$ ls && echo 'yay, command was successful'
combined-output  long-time  newerr     output   somefile error_output     myfile     newoutput  script1
```
As shown before, of course we can redirect stdout of the former command:
```bash
$ ls 1>/dev/null && echo 'yay, command was successful'
yay, command was successful
```
{{% notice note %}}
redirecting to `/dev/null` basically means that we're discarding the output
{{% /notice %}}

#### **Or** (`||`) case

Run a command and run another one if the former failed:
```bash
$ ls /nonexistent || echo 'partition /nonexistent does not exist'
ls: cannot access '/nonexistent': No such file or directory
partition /nonexistent does not exist
```
As shown before, of course we can redirect stderr of the former command:
```bash
$ ls /nonexistent 2>/dev/null || echo 'partition /nonexistent does not exist'
partition /nonexistent does not exist
```

#### Combining `&&` and `||`

Sometimes is useful to run a command when another one is successful, and another one when it fails.

For example consider the following command:
```bash
$ cd /tmp && echo 'command succeeded, removing old files' || echo 'command failed, aborting'
command succedded
```
In case it succeeds we could perform some housekeeping operation and remove old logs. On the other hand if the command failed we would most likely want to abort and exit

Of course at this point we have only `echoes` so nothing is actually done. If we were to perform this sort of housekeeping using these operators it would be something similar to:

* Case of success
    ```bash
    $ cd /tmp && { echo 'command succeeded, removing old files' && find -type f -mtime +2 -delete && echo 'files removed';} || { echo 'command failed, aborting';}
    command succeeded, removing old files
    files removed
    ```
* Case of failure
    ```bash
    $ cd /tmp2 && { echo 'command succeeded, removing old files' && find -type f -mtime +2 -delete && echo 'files removed';} || echo 'command failed, aborting'
    -bash: cd: /tmp2: No such file or directory
    command failed, aborting
    ```

As you can see to perform this operation, things start to get fiddly. In order to group decisions we would need to envelop them in curly braces, and to make things worse, the closing curly brace must have a semicolon just before.
{{% notice warning %}}
Please do not use this as a reference to write long bash scripts. Your future self will appreciate when you have to change and old script without all these conditions in it.
{{% /notice %}}
{{% notice note %}}
The command `find -type f -mtime +2 -delete` means: find files only with more than 2 days older and delete them
{{% /notice %}}


## Extended syntax

Using last example as a reference, let's refactor using an `if` statement:
```bash
if cd /tmp
then
    echo 'command succeeded, removing old files'
    if find -type f -mtime +2 -delete; then
        echo 'files removed'
    else
        echo 'files failed to remove'
    fi
else
    echo 'command failed, aborting'
fi
command succeeded, removing old files
files removed
```
A couple of things to notice here:

* the first line of the if statement can have the `then` next, provided that it's specified as a separate command (using semicolon)
* syntax is super clear and easier to maintain
* there is a bit of repetition in the case of failure
* After the `then` we don't really need a newline or separator, so this would work just fine: `if CONDITION; then echo 'something; fi`

Using the syntax `if TEST; then` as an example. What goes in between `if` and `then` is called a 'test command'. The amount of test commands in Bash could be intimidating at first, but once you get the hang of it, they make a lot of sense and are easy to remember. A list of those can be found in <a href="http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html" target="_blank">here</a>.

As an extended example here's how to ask for another condition just before the default `else`:
```bash
if cd /tmp2
then
    echo 'command succeeded, removing old files'
    if find -type f -mtime +2 -delete; then
        echo 'files removed'
    else
        echo 'files failed to remove'
    fi
elif cd /tmp
then
    echo 'second command succeeded'
else
    echo 'command failed, aborting'
fi
-bash: cd: /tmp2: No such file or directory
second command succeeded
```
