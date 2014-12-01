
## Info

Install `pandoc` before `exemd`.
Website coming soon. 

## Usage

    exemd FILE [ -p | --pdf ] [ -r | --raw ] 
    exemd -h | --help 

    Options:
        -p, --pdf   Generate a pdf
        -r, --raw   Unfold and execute blocks, generate raw markdown
        -h, --help  

    Arguments: 
        FILE       markdown file name.

## Defaults

By default, `exemd` invokes `pandoc` to generate html. If you use `--raw` you will get a raw markdown with expanded blocks. 

*Note*: the `pdf` option does not work at the moment.

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
