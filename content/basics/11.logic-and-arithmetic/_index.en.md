---
title: Logic and Arithmetic
weight: 65
---

Logic and arithmetic operation can give our bash scripts more accuracy and robustness against different types of values

## Arithmetic expressions

In bash to declare an integer is simply done with:

```shell
$ declare -i COUNTER=0
```

Since the variable `COUNTER` now is an integer, we can also do this:

```shell
$ COUNTER+=1
$ echo $COUNTER
1
```

### `let` expression

The 'let' expression in bash signals that the following expression will be arithmetic. By knowing this, we can re-write our previous counter like this:

```shell
$ let counter=10
$ let counter+=1
$ echo $counter
11
```

Even though the expression `let counter+=1` worked, sometimes is good to keep things separated by space to improve readability. To achieve this, we'd have to envelop the whole arithmetic expression in quotes:

```shell
$ let "counter = $counter * 2"
$ echo $counter
22
```

### Double parenthesis

Another way to accomplish a counter is to use double parenthesis:

```shell
$ (( counter += 10 ))
$ echo $counter
32
```

### Dollar sign double parenthesis

Yet another way to do a counter is to use `$(( ))`. In this case the result of the operation will be returned immediately:

```shell
$ echo $(( counter += 10 ))
42
$ echo $counter
42
```

{{% notice tip %}}
You don't need dollar signs to reference the variables inside the arithmetic expression
{{% /notice %}}

## if statement (with arithmetic expressions)

Using arithmetic expressions an if statement looks like this:

```bash
let var=200
if (( var < 200 ))
then
    echo "value too low"
elif (( var > 200 ))
then
    echo "value too high"
else
    echo "value is right"
fi
```

Things to notice:

- We are using the same arithmetic expression we saw earlier
- After `if` and `elif` we must include `then`, but this is not required for `else`

We can build expressions much more powerful than this though. Let's create a script `simpleif.bash` with the following content:

```bash
let number
while true; do
    read -p "Guess the number? " number
    if (( number < 200 )); then
        echo "too low, try again"
    elif (( number > 200 )); then
        echo "too high, try again"
    fi

    if (( number == 200 || CHEAT != 0 )); then
        echo "Yay, you guessed it"
        if (( CHEAT != 0 )); then
            echo "Actually, you're a cheater ^.^"
            exit 1
        fi
        exit 0
    fi
done
```

Now run the script:

```shell
$ CHEAT=1 bash simpleif.bash
Guess the number? 200
Yay, you guessed it
Actually, you're a cheater ^.^
```

Things to point out:

- This expression `number == 200 || CHEAT != 0` is a logical OR, as provided in other programming languages.

## if statement (with test expressions)

### if statement with single square brackets

Has the form `if [ expr ]`

{{% notice tip %}}
The whitespaces around the brackets are absolutely necessary
{{% /notice %}}

There are many test expressions, which are listed in <a target="_blank" href="http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html">here</a>

For example if we wanted to know if a file exists, we can do it with:

```bash
file="testfile"
touch $file
if [ -e $file ]; then
    echo "the file exists"
fi
```

Similarly, sometimes it's useful to check the negation of the test expression. For example, if we were to test if a file does not exist, we can do it with:

```bash
file="nonexistentfile"
if [ ! -e $file ]; then
    echo "the file does not exist"
fi
```

Another thing to point out is that there exist comparison operators in this notation, however they can be grouped into two categories:

#### Lexicographical comparison

It means that the strings get compared in character by character basis. These are: `==`, `>`, and `<`, for example:

```bash
str1="something1"
str2="something2"
if [ "$str1" > "$str2" ]; then
    echo "'$str1' is lexicographically greater than '$str2'"
fi
```

That should give:

```shell
'something1' is lexicographically greater than 'something2'
```

{{% notice tip %}}
It's always a good idea to envelop strings in double quotes, just in case they have spaces
{{% /notice %}}

#### Numerical comparison

These are homogeneous to the arithmetic comparison operators, but now are more a sort of legacy support for backwards compatibility. They include: `-eq`, `-lt`, `-gt`, `-ge`, `-le`.

For example:

```bash
num1=20
num2=34
if [ $num1 -le $num2 ]; then
    echo "'$num1' is less or equal than '$num2'"
fi
```

Which should print:

```shell
'20' is less or equal than '34'
```

For readability purposes, I do prefer to use the arithmetic notation when comparing arithmetic expressions, rather than using these operators.

### if statement with double square brackets

Has the form `if [[ expr ]]`

{{% notice tip %}}
Again, the whitespaces around the brackets are absolutely necessary
{{% /notice %}}

This is a sort of more modern way of comparing in bash. Taken from the <a target="_blank" href="http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_02.html">documentation</a>:

> Contrary to [, [[ prevents word splitting of variable values. So, if VAR="var with spaces", you do not need to double quote \$VAR in a test - eventhough using quotes remains a good habit. Also, [[ prevents pathname expansion, so literal strings with wildcards do not try to expand to filenames. Using [[, == and != interpret strings to the right as shell glob patterns to be matched against the value to the left, for instance: [[ "value" == val* ]]

What that means is that using double brackets we can use powerful comparisons such as the following:

```bash
file1=something.txt
if [[ "$file1" == *.txt ]]; then
    echo "The file specified has 'txt' extension"
fi
```

Another powerful use case is when we want to compare against regular expressions. For example:

```bash
str="the elephant in the room was not only real but just a toy."
if [[ "$str" =~ ^t.*not.*toy.$ ]]; then
    echo "The regular expression pattern has matched"
fi
```

{{% notice tip %}}
We do not need to use double quotes when using double brackets, however I think it's a good practice
{{% /notice %}}
