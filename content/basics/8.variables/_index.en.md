---
title: Variables
weight: 45
---

In bash and many other programming languages, a variable is a container where we can store values and reference/modify them later on.

## Variable names

Must begin with alphanumeric character or underscore, and end with one or more alphanumeric or underscore characters.

By convention bash variables tend to be in uppercase, however that depends on the style of programming. Personally I tend to name variables in upper case when they are in a global scope (at the beginning of a script) , and in lowercase when in local scope (inside a function or statement).

### Declaring a variable

```bash
VAR1="some value"
var1="some other value"
var4='some other value with singlequotes'
var_with_underscores="some value with underscores: ___"
var_with_no_spaces=this_val_with-no-spaces
```

In the above it's good to point out:

- Variable names are case sensitive (just like file names in Linux)
- There is no space whatsoever when assigning a value to a variable (e.g. wrong declarations include -> `var= "some val"`, `var = "some val"`, `var ="some val"`)
- Variables must not start with numbers
- Variables that have spaces as value will need quotes around them (either single or double)
- Variables that do not have spaces as values do not need quotes

### Accessing a variable

Just specify the name of the variable, preceded by dollar sign (`$`):

```bash
$ echo $VAR1
some value
$ echo $var1
some other value
$ echo $var4
some other value with singlequotes
$ echo $var_with_underscores
some value with underscores: ___
$ echo $var_with_no_spaces
this_val_with-no-spaces
```

Now this approach is normally fine when printing a single variable, but not so useful when concatenating:

- two variables together -> $VAR1$var1
- a variable with a string -> \$VAR1somestring

For these cases the best practice is to envelop the name of the variable within curly braces:

```bash
$ echo ${VAR1}${var1}
some valuesome other value
$ echo ${VAR1}s, because life is boring with a single value
some values, because life is boring with a single value
```

Now in that second example, since the value we're printing contains spaces (and it's perfectly supported by echo), it's a good practice to envelop everything in double quotes:

```bash
$ echo "${VAR1}s, because life is boring with a single value"
some values, because life is boring with a single value
```

Note that if single quotes were used instead, the value of the variable would not get substituted as almost always wanted:

```bash
$ echo '${VAR1}s, because life is boring with a single value'
${VAR1}s, because life is boring with a single value
```

## Variable as commands

Let's put a command as the content of a variable:

```bash
custom_ls="ls -lrt"
```

Then if you just expand the value of that variable in the shell:

```bash
$ $custom_ls
total 32
-rw-rw-r-- 1 vagrant vagrant   7 Nov 24 13:20 myfile
-rw-rw-r-- 1 vagrant vagrant 110 Nov 24 14:14 output
[...]
```

### Propagate variable across subshells

{{% notice note %}}
A subshell is when bash is invoked from within bash (either explicitly or implicitly), for example: `$ bash` will return a subshell
{{% /notice %}}

All the variables that we declare, by default will not get propagated to child subshells. This is particularly annoying if we call bash scripts that are expecting some variables to be already defined.

Example of variable not getting propagated to a subshell:

```bash
$ localvar="42 is a great number"
$ echo $localvar
42 is a great number
$ bash
$ echo $localvar

$ exit
$ echo $localvar
42 is a great number
```

In order to make a variable get propagated to subshells, we must first export it:

```bash
$ localvar="42 is a great number"
$ echo $localvar
42 is a great number
$ export localvar
$ bash
$ echo $localvar
42 is a great number
```

{{% notice note %}}
Notice how the export command does not have a dollar sign
{{% /notice %}}

We can also export and define the variable in one go:

```bash
$ export localvar="42 is a great number"
$ echo $localvar
42 is a great number
$ bash
$ echo $localvar
42 is a great number
```

Another way to export variables is by using the command declare with the `-x` flag:

```bash
$ declare -x localvar="42 is a great number"
$ echo $localvar
42 is a great number
$ bash
$ echo $localvar
42 is a great number
```

Going back to the example where we want to pass a specific variable for the duration of the script, we can pass an ephemeral variable like this:

- Create a file `script2` with the following content:
  ```
  echo "Value passed is: $ephemeral_var"
  ```
- Give the file execution permissions
  ```bash
  $ chmod +x script2
  ```
- Run script without specifying the variable
  ```bash
  $ ./script2
  Value passed is:
  ```
- Specify the variable only for the duration of that script
  ```bash
  $ ephemeral_var="42, of course" ./script2
  Value passed is: 42, of course
  ```

## String substitution

Assuming we have the following variable:

```bash
$ myvar="todo muy muy bien"
```

- **Removing trailing strings**: if we were to remove the word `bien` from right to left, we can simply do:
  ```bash
  $ echo "${myvar%bien}"
  todo muy muy
  ```

* **Removing trailing pattern (shell matching file patterns)**:

  - single character (`?` matches any one character): remove last character

  ```bash
  $ echo "${myvar%?}"
    todo muy muy bie
  ```

  - many characters (`*` matches zero or more characters): remove everything after the `m`

  ```bash
  $ echo "${myvar%m*}"
    todo muy
  ```

  - many characters (`*` matches zero or more characters): remove everything after the `m`, make sure it's largest possible match of character `m`

  ```bash
  $ echo "${myvar%%m*}"
    todo
  ```

  - rename filename extension: from `.jpg` to `.png`

  ```bash
  $ imagename=photo1.jpg
  $ echo "${imagename%.jpg}.png"
    photo1.png
  ```

  - extract path from absolute path to filename `/home/vagrant/mydir/myfile.txt`

  ```bash
  $ filename=/home/vagrant/mydir/myfile.txt
  $ echo "path is '${filename%/*}'"
  path is '/home/vagrant/mydir'
  ```

  - **Note**: the bash command `dirname` does exactly this

* **Removing leading pattern (shell matching file patterns)**:

  - single character (`?` matches any one character): remove first character

  ```bash
  $ echo "${myvar#?}"
    odo muy muy bien
  ```

  - many characters (`*` matches zero or more characters): remove everything before the `m`

  ```bash
  $ echo "${myvar#*m}"
    uy muy bien
  ```

  - many characters (`*` matches zero or more characters): remove everything before the `m`, make sure it's largest possible match of character `m`

  ```bash
  $ echo "${myvar##*m}"
    uy bien
  ```

  - parse `username` and `host` parts from string `john@10.0.0.20`

  ```bash
  $ conn_str="john@10.0.0.20"
  $ host="${conn_str%*@}"
  $ echo $host
  10.0.0.20
  $ username="${conn_str%@*}"
  $ echo $username
  john
  ```

  - extract filename from absolute path to filename `/home/vagrant/mydir/myfile.txt`

  ```bash
  $ filename=/home/vagrant/mydir/myfile.txt
  $ echo "filename is '${filename##*/}'"
  filename is 'myfile.txt'
  ```

  - **Note**: the bash command `basename` does exactly this.

* **Replacing pattern from middle of string**:

  - Replace `bien` for `bueno` in string `muy muy bien`

  ```bash
  $ echo "${myvar/bien/bueno}"
    todo muy muy bueno
  ```

  - Note: there's a very powerful bash program called `sed` that does this and much more

## Special variables

- Return value of command ran: stored in `$?`
- Current prompt: `$PS1`
- Current path (where all the programs that can be run are located): `$PATH`
- Home directory: `$HOME`

More information about variables is in <a href="http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html" target="_blank" >here</a>
