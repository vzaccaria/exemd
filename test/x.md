# A Minimal Example of Executed Markdown.

This is a minimal example of using **exemd** to produce an _HTML_ page from _Markdown_. You can check the source here.

## Diagram with [dot](http://www.graphviz.org/)

Taken [from here](http://graphs.grevian.org/example)

```{dot ! xyz}
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


```{ditaa ! }
+--------------+
|              |
| Hello World! |
|              |
+--------------+
```