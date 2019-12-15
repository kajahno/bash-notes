---
title: Flow control
weight: 55
---

Flow control expressions allow us to include additional logic into our bash scripts

## For loop

### Looping over `stdin`

Let's create the simplest for loop in a script:

- create a file `simpleforloop.bash` and place the following content inside:
  ```bash
  for VAR
  do
    echo Hey $VAR
  done
  ```
- change the permissions and run it:
  ```bash
  $ chmod +x simpleforloop.bash
  $ ./simpleforloop.bash one two three
    Hey one
    Hey two
    Hey three
  $
  ```

If no list of values is specified to the for loop, then `stdin` will be used as default. It's important to note that the commands within the `do` and `done` statement will be run for each value specified in the list (each value in `stdin` in this case).

{{% notice note %}}
In this example the variable used was `VAR`, however this doesn't really matter since it's just a container for the iteration variable
{{% /notice %}}

### Looping over a list

This is by far the most common way of using a for loop in bash

Run the following command directly in the shell:

```bash
  for i in $( ls ); do
    echo Hey $i
  done
```

It's interesting to point out that:

- The output (cropped) should be something similar to:
  ```bash
  Hey combined-output
  [...]
  Hey simpleforloop.bash
  Hey somefile
  ```
- We are passing list of values to the for loop: we're gathering the result of running the command `ls` in a subshell
- Each value from the list is assigned to the iteration variable `i`
- The `do` statement was placed inline. This could have also been specified in a new line
- In this case we have only one statement in the loop, `echo Hey $1`, however we can have as many as we wanted (including, other loops, of course)

### Classic C-like for loop in bash

If you're familiar with C-like loops, then this should feel natural. If not, in case you bumped into this you'll know.

Run the following script directly in the shell:

```bash
for ((i=1; i<10; i++)); do
  echo Hey $i
done
```

Things to point out:

- The output (cropped) should be similar to:
  ```bash
  Hey 1
  [...]
  Hey 9
  ```
- Bash automatically assigns the iteration variable for `i`
- We can control the increment of the looping variable: instead of `i++`, we can easily say `i+=2` to increment by 2 after every loop

### Looping over the characters of a string variable

Run the following in the shell:

```bash
var="Portuguese and Spanish have roughly 90% of lexical similarity"
for ((i=0; i<${#var}; i++ ))
do
  echo character[${i}] = ${var:i:1}
done
```

Things to point out:

- The output (cropped) should be similar to:
  ```bash
  character[0] = P
  character[1] = o
  character[2] = r
  [...]
  character[59] = t
  character[60] = y
  ```
- Pay close attention on how we got the character count of the string: `${#var}`

{{% notice note %}}
This is just for fun, handling complicated things like this in bash is probably a bad idea.
{{% /notice %}}

#### Bonus: print the string characters in reverse order

Simple but not straightforward, the following will accomplish the challenge:

```bash
var="Portuguese and Spanish have roughly 90% of lexical similarity"
for ((i=${#var} - 1; i>=0; i-- )); do
  echo character[${i}] = ${var:i:1}
done
```

The output should be similar to:

```bash
character[60] = y
character[59] = t
[...]
character[1] = o
character[0] = P
```

## While loop

Differs from a `for` loop in the sense that it will continue looping while a condition remains `true` (basically non-zero) . For example, let's run the following in the shell:

```bash
i=0
while (( i < 10 ))
do
  echo Hey $i
  i=$((i+1))
done
```

Things to notice:

- The output should be similar to:

  ```shell
  Hey 0
  Hey 1
  [...]
  Hey 9
  ```

- There's a strange `$(( ))`, this is called arithmetic expression and will get covered in the next section
- It's very similar to a `for` loop

### Looping over the result of a pipeline of commands

Let's say, we want to loop over the result of `ls` using a while loop. We can achieve it with:

```bash
ls | while read fname; do
  echo Hey file: $fname
done
```

Things to notice here:

- The output should be similar to:
  ```shell
  Hey file: combined-output
  [...]
  Hey file: somefile
  ```
- The `while` condition relies in the `read` command, which parses each output of the `ls`

## Until loop

There's another loop, the `until` loop. It's syntax is similar to the `while` loop but differs in the sense that the loop will continue until the condition is met (think of it as 'while the condition is not true'). For example (taken from the <a target="_blank" href="https://www.tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-7.html">official documentation</a>):

```bash
COUNTER=20
until [  $COUNTER -lt 10 ]; do
    echo COUNTER $COUNTER
    let COUNTER-=1
done
```

Things to notice:

- The output should be similar to:
  ```bash
  COUNTER 20
  [...]
  COUNTER 10
  ```
  {{% notice note %}}
  Notice how the values printed were the ones when the condition was not true (zero)
  {{% /notice %}}
- There's a `let` command that will get covered in the subsequent section

## Case statement

It's a powerful statement that allows us to easily match input patterns.
{{% notice tip %}}
In other programming languages this is known also as 'switch' statement
{{% /notice %}}

Let's create the script `simplecase.bash`, with the following content:

```bash
read -p "Answer 'yes' or 'no': " ANS
case "$ANS" in
  yes) echo "OK"
    ;;
  (no) echo "it's a 'no' then, thanks"
    ;;
  *)
    echo "you didn't specify anything :("
    exit 1
    ;;
esac
```

Now run the script:

```shell
$ bash simplecase.bash
Answer 'yes' or 'no': no
it's a 'no' then, thanks
```

Things to notice:

- The statement begins and ends with `case` and `esac`, respectively
- The values `yes` and `no` are actually shell pattern matches, so we could have specified `y*` and `n*` and the result would be the same
- If nothing is matched, then the shell pattern match (`*`) for `zero or more characters` will kick in and return error (1)
- The conditions to evaluate must be separated by double semicolon `;;`
- After the parenthesis you can either put the statement inline or in a new line
- The leading parenthesis in `(no)` is optional. In fact, must people tend to not specify it

### Continue matching patterns

As you've noticed, once there's a pattern match the `case` statement will run the respective block and then exit the statement. Sometimes though, we want to continue matching all the remaining patterns (in order). This is possible since bash 4.0+.

Let's create another script `simplecase2.bash` with the following content:

```bash
input="this is a dummy text"
case "$input" in
  *a*)
    echo "Character 'a' is present"
    ;;&
  *is*)
    echo "Word 'is' is present"
    ;&
  *text)
    echo "Var ends with word 'text'. Now we exit with error"
    exit 1
    ;;
esac
```

Now run the script:

```shell
$ bash simplecase2.bash
Character 'a' is present
Word 'is' is present
Var ends with word 'text'. Now we exit with error
```

Things to notice:

- The feature to continue matching patterns is activated when we specify either `;;&` or `;&` at the end of each pattern match
