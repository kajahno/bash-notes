---
title: Bash scripts
weight: 50
---

Bash scripts enable us to reutilize a set of commands and provide robustness on our daily actions. Knowing this is a must for doing any kind of automation using bash.

## Reading parameters

Consider the following script:

* create a file `params1.bash` and place the content in:
    ```
    echo $0
    echo $1
    echo $2
    ```
* change the permissions and run it:
  ```bash
  $ chmod +x params1.bash
  $ ./params1.bash one
  ./script1.bash
  one
  ```

As you can see the parameter `$0` corresponds to the name of the script, and any other command line parameter is enumerated from `$1` onwards.

{{% notice tip %}}
Difference between command line parameter, argument, and option thanks to <a href="https://stackoverflow.com/a/36495940/5486521" target="_blank">this fellow</a>
{{% /notice %}}


### Accessing all parameters

* create a file `params2.bash` and place the following content inside:
  ```
  echo $#
  echo $*
  echo $@
  ```
* change permissions and run it with some params:
  ```bash
  $ chmod +x params2.bash
  $ ./params2.bash one two three
    3
    one two three
    one two three
  ```

As you see:

* `$#`: counts how many arguments were passed
* `$*`: provides all arguments
* `$@`: provides all arguments

Now, even though in both `$*` and `$@` we appear to have the same result, there's a subtle difference. Let's modify our script to call another script as see what's going on:

* Create another script `params3.bash` with the following content:
  ```
  echo "number of args: $#"
  ```
* Give it execution permissions
  ```bash
  $ chmod +x params3.bash
  ```
* Now edit the `params2.bash` with the following content:
  ```bash
    echo $#
    ./params3.bash $*
    ./params3.bash $@
    ./params3.bash "$*"
    ./params3.bash "$@"
  ```
* Run it with a particular set of params and observe the result:
  ```bash
  $ ./params2.bash one two three "and four"
    4
    number of args: 5
    number of args: 5
    number of args: 1
    number of args: 4
  ```

Sure enough those results might not be what you expected. Let's go case by case:

* `./params3.bash $*`: sent the following args -> one two three and four
* `./params3.bash $@`: sent the following args -> one two three and four
* `./params3.bash "$*"`: sent the following args -> "one two three and four"
* `./params3.bash "$@"`: sent the following args -> 'one two three "and four"'

Normally the intended thing we want to do, which is to forward all arguments, is accomplished in the last case. We are going to see more of this when covering arrays.
