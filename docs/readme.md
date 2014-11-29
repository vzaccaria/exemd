# {%= name %} {%= badge("fury") %}

> {%= description %}

{%= include("install-global") %}

## Usage

    exemd FILE [ -p | --pdf ] [ -r | --pure ] 
    exemd -h | --help 

    Options:
        -p, --pdf   Generate a pdf
        -r, --raw   Unfold and execute blocks, generate raw markdown
        -h, --help  

    Arguments: 
        FILE       markdown file name.


## Author
{%= include("author") %}

## License
{%= copyright() %}
{%= license() %}

***

{%= include("footer") %}