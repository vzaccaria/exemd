# A Minimal Example for Markdown

This is a minimal example of using **exemd** to produce an _HTML_ page from _Markdown_.

## exemd code chunks

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

## Another diagram

```{dot ! abc}
digraph {
        a -> b[label="0.2",weight="0.2"];
        a -> c[label="0.4",weight="0.4"];
    }
```

## Ditaa

```{ditaa ! }
+--------------+
|              |
| Hello World! |
|              |
+--------------+
```