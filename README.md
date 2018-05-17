
# blackmagic

Automagically Convert XML to JSON

## Description

Convert XML to JSON. Uses the ‘xml-js’ ‘npm’ library
<https://www.npmjs.com/package/xml-js> by Yousuf Almarzooqi.

## NOTE

Please reconsider your apparent desire to use this package.

Automagic conversion of XML to JSON is *rarely* a good idea and a path
fraught with peril. There are *so many* options to tweak to ensure you
get what you think you want but likely truly want something else
entirely, such as a more minimal extract of the original XML file.

Seriously consider parsing the XML then using `purrr` idioms to extract
the data you need into a proper `list` and *then* call
`jsonlite::toJSON()` on said `list`.

## What’s Inside The Tin

The following functions are implemented:

  - `xml_to_json`: Convert XML to JSON

## Installation

``` r
devtools::install_github("hrbrmstr/blackmagic")
```

## Usage

``` r
library(blackmagic)

# current verison
packageVersion("blackmagic")
```

    ## [1] '0.1.0'

### Sample (defaults)

``` r
xml <- '<?xml version="1.0" encoding="utf-8"?>
<note importance="high" logged="true">
    <title>Happy</title>
    <todo>Work</todo>
    <todo>Play</todo>
</note>'

cat(xml_to_json(xml))
```

    ## {"declaration":{"attributes":{"version":"1.0","encoding":"utf-8"}},"elements":[{"type":"element","name":"note","attributes":{"importance":"high","logged":"true"},"elements":[{"type":"element","name":"title","elements":[{"type":"text","text":"Happy"}]},{"type":"element","name":"todo","elements":[{"type":"text","text":"Work"}]},{"type":"element","name":"todo","elements":[{"type":"text","text":"Play"}]}]}]}

### Sample (some saner tweaks)

``` r
'<?xml version="1.0" encoding="UTF-8"?>
<bookstore>
  <book category="cooking">
    <title lang="en">Everyday Italian</title>
    <author>Giada De Laurentiis</author>
    <year>2005</year>
    <price>30.00</price>
  </book>
  <book category="children">
    <title lang="en">Harry Potter</title>
    <author>J K. Rowling</author>
    <year>2005</year>
    <price>29.99</price>
  </book>
  <book category="web">
    <title lang="en">Learning XML</title>
    <author>Erik T. Ray</author>
    <year>2003</year>
    <price>39.95</price>
  </book>
</bookstore>' -> books

cat(xml_to_json(books, spaces = 2, compact = TRUE, ignoreDeclaration = TRUE))
```

    ## {
    ##   "bookstore": {
    ##     "book": [
    ##       {
    ##         "_attributes": {
    ##           "category": "cooking"
    ##         },
    ##         "title": {
    ##           "_attributes": {
    ##             "lang": "en"
    ##           },
    ##           "_text": "Everyday Italian"
    ##         },
    ##         "author": {
    ##           "_text": "Giada De Laurentiis"
    ##         },
    ##         "year": {
    ##           "_text": "2005"
    ##         },
    ##         "price": {
    ##           "_text": "30.00"
    ##         }
    ##       },
    ##       {
    ##         "_attributes": {
    ##           "category": "children"
    ##         },
    ##         "title": {
    ##           "_attributes": {
    ##             "lang": "en"
    ##           },
    ##           "_text": "Harry Potter"
    ##         },
    ##         "author": {
    ##           "_text": "J K. Rowling"
    ##         },
    ##         "year": {
    ##           "_text": "2005"
    ##         },
    ##         "price": {
    ##           "_text": "29.99"
    ##         }
    ##       },
    ##       {
    ##         "_attributes": {
    ##           "category": "web"
    ##         },
    ##         "title": {
    ##           "_attributes": {
    ##             "lang": "en"
    ##           },
    ##           "_text": "Learning XML"
    ##         },
    ##         "author": {
    ##           "_text": "Erik T. Ray"
    ##         },
    ##         "year": {
    ##           "_text": "2003"
    ##         },
    ##         "price": {
    ##           "_text": "39.95"
    ##         }
    ##       }
    ##     ]
    ##   }
    ## }

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
