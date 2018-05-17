
# blackmagic

## Description

Convert XML to JSON. Uses the ‘xml-js’ ‘npm’ library
<https://www.npmjs.com/package/xml-js> by Yousuf Almarzooqi.

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
