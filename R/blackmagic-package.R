#' Automagically Convert XML to JSON
#'
#' Convert XML to JSON. Uses the 'xml-js' 'npm' library
#' <https://www.npmjs.com/package/xml-js> by Yousuf Almarzooqi.
#'
#' Please reconsider your apparent desire to use this package.
#'
#' Automagic conversion of XML to JSON is _rarely_ a good idea and a path fraught
#' with peril. There are _so many_ options to tweak to ensure you get what you think
#' you want but likely truly want something else entirely, such as a more minimal
#' extract of the original XML file.
#'
#' Seriously consider parsing the XML then using `purrr` idioms to extract the data
#' you need into a proper `list` and _then_ call `jsonlite::toJSON()` on said `list`.
#'
#' @md
#' @name blackmagic
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import V8
NULL
