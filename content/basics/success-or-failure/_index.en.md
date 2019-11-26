---
title: Success of Failure
weight: 40
---

In previous examples we've referred to 'success' or 'failure' when running commands within bash. This is closely related to the return codes of the programs we call in our commands. To find what was the return code of a particular program, just access the magic variable `$?` after invoking the program.

For this section create a file named `return-codes` and put the following content it in:
```
if [ $1 == 'success' ]
then
        echo 'success'
        exit 0
else
        echo 'failure' >&2
        exit 1
fi
```
{{% notice note %}}
The `$1` is making reference to the first argument passed to the bash script at invocation
{{% /notice %}}

## What is 'success' then?

It's when a program returns a return code of 0.

For example:
```bash
$ echo hi there
hi there
$ echo $?
0
```

Now using our little script:
```bash
$ bash return-codes success
success
$ echo $?
0
```

## And what about 'failure'?

It's when a program returns a non-zero return code.

For example:
```bash
$ ls non-existent
ls: cannot access 'non-existent': No such file or directory
$ echo $?
2
```

And using our script:
```bash
$ bash return-codes fail
fail
$ echo $?
1
```
