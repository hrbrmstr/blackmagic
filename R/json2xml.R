#' Convert JSON to XML
#'
#' Please reconsider your apparent desire to use this function.\cr
#' \cr
#' Automagic conversion of JSON to XML is _rarely_ a good idea and a path fraught
#' with peril. There are _so many_ options to tweak to ensure you get what you think
#' you want but likely truly want something else entirely, such as a more minimal
#' extract of the original JSON file.\cr
#' \cr
#' Seriously consider parsing the JSON then using `purrr` idioms to extract the data
#' you need into a proper `list` and _then_ call [xml2::as_xml_document()] on said `list`.
#'
#' @md
#' @note the `compact` parameter should nigh always be `TRUE`.
#' @param doc JSON document (character)
#' @param spaces Number of spaces to be used for indenting JSON output. Default: `0`.
#' @param compact WWhether the _input_ object is in compact form or not. Default `TRUE`.
#' @param fullTagEmptyElement Whether to produce element without sub-elements as full tag pairs. Default `FALSE`
#' @param indentCdata Whether to write CData in a new line and indent it. Default `FALSE`
#' @param indentAttributes Whether to print attributes across multiple lines and indent them (when spaces is not 0). Default `FALSE`
#' @param ignoreDeclaration Whether to ignore writing declaration directives of xml.  Default `FALSE`
#' @param ignoreInstruction Whether to ignore writing processing instruction of xml.  Default `FALSE`
#' @param ignoreAttributes Whether to ignore writing attributes of the elements.  Default `FALSE`
#' @param ignoreComment Whether to ignore writing comments of the elements. Default `FALSE`
#' @param ignoreCdata Whether to ignore writing CData of the elements.  Default `FALSE`
#' @param ignoreDoctype Whether to ignore writing Doctype of the elements.  Default `FALSE`
#' @param ignoreText Whether to ignore writing texts of the elements.  Default `FALSE`
#' @export
#' @examples
#' json_to_xml(jsonlite::toJSON(head(mtcars, 2)), spaces=2)
#'
#' json_to_xml("https://httpbin.org/uuid", spaces=2)
json_to_xml <- function(doc, spaces = 0, compact = TRUE,
                        fullTagEmptyElement = FALSE, indentCdata = FALSE,
                        indentAttributes = FALSE, ignoreDeclaration = FALSE,
                        ignoreInstruction = FALSE, ignoreAttributes = FALSE,
                        ignoreComment = FALSE, ignoreCdata = FALSE, ignoreDoctype = FALSE,
                        ignoreText = FALSE) {

  if (is_url(doc)) {
    con <- url(doc)
    txt <- readLines(con, warn = FALSE)
    close(con)
    doc <- paste0(txt, collapse="\n")
  }

  compact <- if (compact) "true" else "false"
  fullTagEmptyElement <- if (fullTagEmptyElement) "true" else "false"
  indentCdata <- if (indentCdata) "true" else "false"
  indentAttributes <- if (indentAttributes) "true" else "false"
  ignoreDeclaration <- if (ignoreDeclaration) "true" else "false"
  ignoreInstruction <- if (ignoreInstruction) "true" else "false"
  ignoreAttributes <- if (ignoreAttributes) "true" else "false"
  ignoreComment <- if (ignoreComment) "true" else "false"
  ignoreCdata <- if (ignoreCdata) "true" else "false"
  ignoreDoctype <- if (ignoreDoctype) "true" else "false"
  ignoreText <- if (ignoreText) "true" else "false"

  js_param <- sprintf(
    "{
spaces: %s,
compact : %s,
fullTagEmptyElement : %s,
indentCdata : %s,
indentAttributes : %s,
ignoreDeclaration : %s,
ignoreInstruction : %s,
ignoreAttributes : %s,
ignoreComment : %s,
ignoreCdata : %s,
ignoreDoctype : %s,
ignoreText : %s
}", spaces, compact, fullTagEmptyElement, indentCdata, indentAttributes,
    ignoreDeclaration, ignoreInstruction, ignoreAttributes, ignoreComment,
    ignoreCdata, ignoreDoctype, ignoreText
  )

  js_param <- gsub("\n", " ", js_param)

  if (length(.pkgenv$ctx) == 0) {
    ctx <- V8::v8()
    ctx$source(system.file("js/bundle.js", package="blackmagic"))
    assign("ctx", ctx, envir=.pkgenv)
  }

  .pkgenv$ctx$call("incant.json2xml", doc, JS(js_param))

}
