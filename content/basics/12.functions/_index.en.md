---
title: Functions
weight: 70
---

Functions provide with the ability of reuse code and more importantly to follow the DRY principle: Don't Repeat Yourself.

## Function definition

A function can be defined as follows:
```bash
function myfunc () {
    echo "Hey, there!"
}
```

Then to invoke it as if it were a bash command or program, just run it:
```shell
$ myfunc
Hey, there!
```

There are alternative syntaxes to declare functions. All of the following are accomplishing the same:

### No optional parenthesis at the end

```bash
function myfunc {
    echo "Hey, there!"
}
```

### No word 'function' but implicit with parenthesis

```bash
myfunc() {
    echo "Hey, there!"
}
```

## Grouping blocks of a function

Even though normally we'd want to run a function as part of the main shell. Sometimes it's useful not to do so. Let's have a look at the following examples.

### Run function in a subshell

```bash
function mysubshellfunc() (
    echo "Hey, I'm running from within a subshelll"
)
```

The implication of this is that the variables that can be accessed will be limited.

{{% notice tip %}}
It's recommended to previously export variables when invoking a subshell
{{% /notice %}}

### Run only arithmetic expressions

```bash
function myarithmeticfunction() ((
    C+=1
))
```

## Function parameters

For the duration of the function execution, the parameters beginning with dollar (e.g. $1, $2, ... ) are re-defined to store the values passed when invoking the function. For example

```bash
function myfuncwithparams(){
    echo "You've specified $# params: $@. Let's print some of them: '$1', '$2'"
}
myfuncwithparams "one"
myfuncwithparams "one" 2 "three and four"
```

Of course, the output should be:
```shell
You've specified 1 params: one. Let's print some of them: 'one', ''
You've specified 3 params: one 2 three and four. Let's print some of them
: 'one', '2'
```

Also using some string substitutions we could make this a bit more smart:
```bash
function myfuncwithparams(){
    msg="You've specified $# params: $@."
    if (( $# < 1 )); then
        echo "No params were specified :("
    elif (( $# == 1 )); then
        echo "${msg/params/param} Let's print it: '$1'"
    else
        echo "${msg} Let's print some of them: '$1'. '$2'"
    fi
}
myfuncwithparams
myfuncwithparams "one"
myfuncwithparams "one" 2 "three and four"
```

Of course, the output should be:
```shell
No params were specified :(
You've specified 1 param: one. Let's print it: 'one'
You've specified 3 params: one 2 three and four. Let's print some of them
: 'one'. '2'
```

{{% notice tip %}}
It's quite handy to do string substitutions like the oe above
{{% /notice %}}
