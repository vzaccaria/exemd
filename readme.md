# exemd [![NPM version](https://badge.fury.io/js/exemd.svg)](http://badge.fury.io/js/exemd)


> Pre-process markdown code blocks with external tools to produce html. Because we want to do everything with markdown right? 

## Install globally with [npm](npmjs.org):

```bash
npm i -g exemd
```

## What is it

It is a markdown pre-processor that runs code inside *code blocks*, by pasting the output back into the original document. It can produce either processed markdown (with inlined SVG or base64 encoded png) or HTML.


## Usage

  Usage:
      exemd FILE [ -r | --raw ] [ -g | --force-png ] [ -p | --pdf ]  
      exemd -h | --help  

  Options:  
        -g, --force-png     Generate html+png(inline). Default is html+svg(inline).  
        -r, --raw           Generates md+png(inline).  
        -p, --pdf           Generates md+pdf(external). Can be used by pandoc to generate pdf docs.  
        -h, --help  

  Arguments:  
      FILE       markdown file name.  

## News

It supports `pdf` now (March 2015). Stay tuned for other goodies coming in.

## Available plugins:

* `exemd-dot`       (Graphviz dot)
* `exemd-ascidia`   (Ascidia)
* `exemd-ditaa`     (Ditaa plugins)
* `exemd-pn`        (Petri nets)

Look [here](http://www.vittoriozaccaria.net/exemd/) for examples.

## Defaults

By default, `exemd` invokes `pandoc` to generate html with inlined svg. To get raw markdown, use `--raw` or `--pdf`.

## Syntax

Each code block should begin with the language specifier followed by a bang (`!`) between brackets `{}`, e.g., if you have a diagram in the dot language:

    ```{dot !}

    digraph {
            a -> b[label="0.2",weight="0.2"];
            a -> c[label="0.4",weight="0.4"];
            c -> b[label="0.6",weight="0.6"];
            c -> e[label="0.6",weight="0.6"];
            e -> e[label="0.1",weight="0.1"];
            e -> b[label="0.7",weight="0.7"];
        }

    ```

`exemd` will invoke the `exemd-dot` plugin (which should be installed separately). The plugin will parse the block code by invoking the actual `dot` executable and the parsed `svg` will be pasted into the final markdown (or html).

Depending on the plugin, you can also pass parameters (just as in org-mode)

    ```{plugin-name ! plugin parameters string}


    ```

## Plugins

Look for npm modules prefixed with `exemd`. I wrote only `exemd-dot` and `exemd-ditaa` for diagrams. Feel free to provide plugins for R (like `kintr`) or other languages.

Each plugin should export a `process(block, opts)` function, where:

* `block` is the string representing the inner part of the block code
* `opts` is an object with the following properties:

    - `tmpdir` an already setup temporary directory where the plugin can mess around but not delete.
    - `params` the string following the bang (`!`) in the block declaration
    - `target-mode` it can be either `html`, `pdf`, or `raw`

The `process` function should return the markdown text to replace the original block either directly or through a promise.


## Author

**Vittorio Zaccaria**
 
+ [github/vzaccaria](https://github.com/vzaccaria)
+ [twitter/vzaccaria](http://twitter.com/vzaccaria) 

## License
Copyright (c) 2015 Vittorio Zaccaria  
Released under the  license

***

_This file was generated by [verb-cli](https://github.com/assemble/verb-cli) on March 16, 2015._
