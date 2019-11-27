---
title: IO Redirection
weight: 15
---

{{<mermaid align="center">}}
graph LR;
    inp[stdin] --> p(program)
    p --> stdout[stdout]
    p --> stderr[stderr]

    classDef middle stroke:#333,stroke-width:4px;
    classDef edge fill:#fff,stroke:#333,stroke-width:0px;
    class p middle;
    class inp edge;
    class stdout edge;
    class stderr edge;
{{< /mermaid >}}

By convention any shell opens three file descriptors when a program is run:

* **Standard input (stdin)**: feeds the program with data
* **Standard output (stdout)**: normally prints messages in the terminal
* **Standard error (stderr)**: normally prints error messages in the terminal (when things fail)

These three file descriptors are referred as non-negative integers (defined by the POSIX standard):

* stdin: 0
* stdout: 1 (this is the default)
* stderr: 2

A very powerful feature of bash (and other shells) is input and output redirection.
If no redirection is specified, by default all three file descriptors are connected to the terminal
(so the information will be displayed)

## Run program with no redirection
```bash
$ ls -l
total 4
-rw-rw-r-- 1 vagrant vagrant 7 Nov 24 13:20 myfile
```

## Redirect standard output
```bash
$ ls -l 1> output
```

As you see, nothing was printed. The output has been redirected to the file `output`.
If we print the content of this file we'll see that indeed the output is there:
```bash
$ cat output
total 4
-rw-rw-r-- 1 vagrant vagrant 7 Nov 24 13:20 myfile
```

Since the file descriptor 1 is the default file descriptor in bash, we can simple run the following and achieve the same result:
```bash
$ ls -l >output
$ cat output
total 4
-rw-rw-r-- 1 vagrant vagrant 7 Nov 24 13:20 myfile
```

## Redirect standard error

To redirect the standard error, we first need to create an error:
```bash
$ ls --bad-usage
ls: unrecognized option '--bad-usage'
Try 'ls --help' for more information.
```
As you see, that option `--bad-usage` doesn't really form part of the command `ls`. However, because by default everything is redirected to the terminal, we also see the stderr output.

Let's redirect that to a new file:
```bash
$ ls --bad-usage 2> error_output
```
Notice how there was nothing printed to the terminal, however by inspecting the content of the file we can confirm that indeed we have successfully redirected stderr:
```bash
$ cat error_output
ls: unrecognized option '--bad-usage'
Try 'ls --help' for more information.
```

## Redirect stdout and stderr

We can combine both output redirections in a single line:
```bash
$ ls -l output non-existing-file >newoutput 2>newerr
```
Nothing will get printed in the terminal. However by inspecting the content of those two new files `newoutput` and `newerr` we can confirm that the redirection took place:
```bash
$ cat newoutput
-rw-rw-r-- 1 vagrant vagrant 110 Nov 24 14:14 output
$ cat newerr
ls: cannot access 'non-existing-file': No such file or directory
```

## Combine stdout and stderr
Sometimes is pretty convenient to redirect both `stdout` and `stderr` a single file.
This can be achieved with:
```bash
$ ls -l output non-existing-file >combined-output 2>&1
```
In this case we are explicitly telling bash to combine (or pipe) stderr into stdout.
Inspecting the new file:
```bash
$ cat combined-output
ls: cannot access 'non-existing-file': No such file or directory
-rw-rw-r-- 1 vagrant vagrant 110 Nov 24 14:14 output
```
{{% notice note %}}
A shorthand for this syntax is: `ls -l output non-existing-file &>combined-output`
{{% /notice %}}

## Redirect stdin
For this we need to make sure the program we use supports stdin.

The program `wc` prints words, lines, and the byte count of the specified input. For example:
```bash
$ wc combined-output
  2  18 118 combined-output
```
`wc` is using the input file specified as argument. Running `wc` with no arguments, and typing manually:
```bash
$ wc
this is a test
second line
[CRTL+d]
      2       6      27
```
Will produce the output base on what was specified in stdin. We use CRTL+d to indicate the end of input. In this occasion, of course, `wc` is reading directly from stdin.

Now if we were to redirect stdin, and specify a file as input instead of manually typing the content, we can by running:
```bash
$ wc <combined-output
  2  18 118
```

## Redirect stdin with a heredoc

When redirecting stdin we also have a way to explicitly specify the input, with a custom delimiter (not the interactive `CTRL-d`)

This can be achieved with the following:
```bash
$ wc <<delimiter
> this is a test
> with a custom delimiter
> delimiter
 2  8 39
```
In this case the `delimiter` will only act as such if it's the only word in a line of input. This way of redirecting is called here document or heredoc.
