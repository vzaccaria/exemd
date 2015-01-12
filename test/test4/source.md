# A Minimal Example of Executed Markdown.

Ditaa is:

> ... a small command-line utility written in Java, that can convert diagrams drawn using ascii art ('drawings' that contain characters that resemble lines like | / - ). into proper bitmap graphics

Here we are using the [`exemd-ditaa`](https://www.npmjs.org/package/exemd-dot) plugin to produce a base64-encoded inlined image taken from the project front page:


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

