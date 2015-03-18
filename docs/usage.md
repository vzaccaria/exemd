Usage:
    exemd list
    exemd FILE [ -r | --raw ] [ -g | --force-png ] [ -p | --pdf ]
    exemd -h | --help

Options:
    -g, --force-png     Generate html+png(inline). Default is html+svg(inline).
    -r, --raw           Generate md+png(inline).
    -p, --pdf           Generate md+pdf(external). Output can be used by pandoc to generate pdf docs.
    -h, --help

Commands:
    list                List available plugins

Arguments:
    FILE                markdown file name.
