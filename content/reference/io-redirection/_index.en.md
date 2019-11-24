---
title: io-redirection
weight: 20
---

Commands related to input and output

| Command                | Description                                                      |
| :--------------------- | :--------------------------------------------------------------- |
| PROGRAM >stdout        | redirect standard output of program to file `stdout`             |
| PROGRAM 2>stderr       | redirect standard error output of program to file `stderr`       |
| PROGRAM >combined 2>&1 | redirect stderr and stdout outputs of program to file `combined` |
| PROGRAM &>combined     | redirect stderr and stdout outputs of program to file `combined` |
| PROGRAM < combined     | reads file `combined` and sends it as input to the program       |
