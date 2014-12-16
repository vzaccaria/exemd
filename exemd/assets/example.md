# A Minimal Example of Executed Markdown.

This is a minimal example of using **exemd** to produce an _HTML_ page from _Markdown_. You can check [the source here](example.md). The resulting html has been generated with the following command line:

`exemd example.md`

## Diagram with [dot](http://www.graphviz.org/)
`dot` is a language for "hierarchical" or layered drawings of directed graphs. It is part of the [graphviz](http://www.graphviz.org/) package. Here we are using the [`exemd-dot`](https://www.npmjs.org/package/exemd-dot) plugin to draw a diagram [from this page](http://graphs.grevian.org/example):

```{dot ! }
digraph {
        a -> b[label="0.2",weight="0.2"];
        a -> c[label="0.4",weight="0.4"];
        c -> b[label="0.6",weight="0.6"];
        c -> e[label="0.6",weight="0.6"];
        e -> e[label="0.1",weight="0.1"];
        e -> b[label="0.7",weight="0.7"];
    }
```

## Diagram with [Ditaa](http://ditaa.sourceforge.net/) 

Ditaa is:

> ... a small command-line utility written in Java, that can convert diagrams drawn using ascii art ('drawings' that contain characters that resemble lines like | / - ). into proper bitmap graphics

Here we are using the [`exemd-ditaa`](https://www.npmjs.org/package/exemd-dot) plugin to produce a base64-encoded inlined image taken from the project front page:

```{ditaa ! }
    +--------+   +-------+    +-------+
    |        | --+ ditaa +--> |       |
    |  Text  |   +-------+    |diagram|
    |Document|   |!magic!|    |       |
    |     {d}|   |       |    |       |
    +---+----+   +-------+    +-------+
        :                         ^
        |       Lots of work      |
        +-------------------------+
```

## Diagram with [Ascidia](https://github.com/Frimkron/Ascidia)

A command-line utility for rendering technical diagrams from ASCII art.

This:

```
               O     
              -|-  -.
              / \   | 
              User  | Request
                    V
 Foobar         +--------+       .------.
  Layer         |  Acme  |       '------'
- - - - - - +   | Widget |<----->|      |
   .----.   ;   +--------+       |      |
  | do-  |  ;       |            '------'
  |  dad |--^--<|---+            Database
   '----'   ;
            ;
```

becomes this:

```{ascidia !}
               O     
              -|-  -.
              / \   | 
              User  | Request
                    V
 Foobar         +--------+       .------.
  Layer         |  Acme  |       '------'
- - - - - - +   | Widget |<----->|      |
   .----.   ;   +--------+       |      |
  | do-  |  ;       |            '------'
  |  dad |--^--<|---+            Database
   '----'   ;
            ;
```
