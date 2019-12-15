---
title: Command substitution
weight: 60
---

Subshell shorthands formally known as command substitutions allows us to use a shorthand and run command within a subshell. The idea is to run a command and operate with the result in `stdout` immediately. See the official documentation in <a target="_blank" href="http://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html">here</a>. 

Basically there are two types:

### using backticks or backquotes

```bash
echo `ls`
```

### using dollar + parenthesis

```bash
echo $(ls)
```

Even though they both accomplish the same, it's preffered the second method since it allows commands to be nested (which is not possible by using backticks)
