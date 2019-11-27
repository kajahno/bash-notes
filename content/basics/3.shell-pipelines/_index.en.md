---
title: Shell Pipelines
weight: 20
---

{{<mermaid align="center">}}
graph LR;
    stdout1 -- PIPE --> inp2
    subgraph program one
        inp1[stdin] --> p1(program)
        p1 --> stdout1[stdout]
        p1 --> stderr1[stderr]
        stderr1 -. optional .-> stdout1
    end
    subgraph program two
        inp2[stdin] --> p2(program)
        p2 --> stdout2[stdout]
        p2 --> stderr2[stderr]
    end
    classDef middle stroke:#333,stroke-width:4px;
    classDef edge fill:#ffffde,stroke:#333,stroke-width:0px;
    class p middle;
    class inp1 edge;
    class inp2 edge;
    class stdout1 edge;
    class stderr1 edge;
    class stdout2 edge;
    class stderr2 edge;
{{< /mermaid >}}

Some shells such as bash provide the ability of chaining program commands together. The way it works is that the standard output of one program as input to another program, all chained together by using the pipe (`|`) character.


## Print content of a file and calculate word count

This can be done with the following command:
```bash
$ cat ~/.profile | wc
     20      99     655
```
As we see, the output of the file `~/.profile` has been redirected as input to the program `wc`

## List files redirecting stderr and calculate word count
```bash
$ ls combined-output non-existent 2>&1 | wc -l
2
```
Regardless of both files existing or not, our output will show the same count since we have redirected stderr to stdout.
