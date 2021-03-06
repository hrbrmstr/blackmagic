#' Convert XML to JSON
#'
#' Please reconsider your apparent desire to use this function.\cr
#' \cr
#' Automagic conversion of XML to JSON is _rarely_ a good idea and a path fraught
#' with peril. There are _so many_ options to tweak to ensure you get what you think
#' you want but likely truly want something else entirely, such as a more minimal
#' extract of the original XML file.\cr
#' \cr
#' Seriously consider parsing the XML then using `purrr` idioms to extract the data
#' you need into a proper `list` and _then_ call [jsonlite::toJSON()] on said `list`.
#'
#' @md
#' @param doc XML document (character, `xml_document` (`xml2`), `XMLInternalDocument` (`XML`) or a URL to be fetched)
#' @param spaces Number of spaces to be used for indenting JSON output. Default: `0`.
#' @param compact Whether to produce detailed object or compact object. Default `FALSE`.
#' @param trim Whether to trim whitespace characters that may exist before and after the text. Default `FALSE`.
#' @param nativeType Whether to attempt converting text of numerals or of boolean values to native type.  Default `FALSE`.
#' @param addParent Whether to add parent property in each element object that points to parent object. Default `FALSE`.
#' @param alwaysArray Whether to always put sub element, even if it is one only, as an item inside an array.  Default `FALSE`.
#' @param alwaysChildren Whether to always generate elements property even when there are no actual sub elements. Default `FALSE`.
#' @param instructionHasAttributes Whether to parse contents of Processing Instruction as attributes or not.  Default `FALSE`.
#' @param ignoreDeclaration Whether to ignore parsing declaration property. That is, no declaration property will be generated. Default `FALSE`.
#' @param ignoreInstruction Whether to ignore parsing processing instruction property.  Default `FALSE`.
#' @param ignoreAttributes Whether to ignore parsing attributes of elements.That is, no attributes property will be generated. Default `FALSE`.
#' @param ignoreComment Whether to ignore parsing comments of the elements. That is, no comment will be generated. Default `FALSE`.
#' @param ignoreCdata Whether to ignore parsing CData of the elements. That is, no cdata will be generated. Default `FALSE`.
#' @param ignoreDoctype Whether to ignore parsing Doctype of the elements. That is, no doctype will be generated. Default `FALSE`.
#' @param ignoreText Whether to ignore parsing texts of the elements. That is, no text will be generated. Default `FALSE`.
#' @export
#' @examples
#' xml <- '<?xml version="1.0" encoding="utf-8"?>
#' <note importance="high" logged="true">
#'     <title>Happy</title>
#'     <todo>Work</todo>
#'     <todo>Play</todo>
#' </note>'
#'
#' xml_to_json(xml)
#'
#' xml_to_json(xml2::read_xml(xml))
#'
#' xml_to_json(XML::xmlParse(xml))
#'
#' \dontrun{
#' xml_to_json("https://httpbin.org/xml")
#' }
xml_to_json <- function(doc, spaces = 0,
                        compact = FALSE, trim = FALSE, nativeType = FALSE,
                        addParent = FALSE, alwaysArray = FALSE, alwaysChildren = FALSE,
                        instructionHasAttributes = FALSE, ignoreDeclaration = FALSE,
                        ignoreInstruction = FALSE, ignoreAttributes = FALSE,
                        ignoreComment = FALSE, ignoreCdata = FALSE, ignoreDoctype = FALSE,
                        ignoreText = FALSE) {

  if (inherits(doc, "xml_document")) { doc <- as.character(doc) }

  if (inherits(doc, "XMLInternalDocument")) { doc <- XML::saveXML(doc) }

  if (is_url(doc)) {
    con <- url(doc)
    txt <- readLines(con, warn = FALSE)
    close(con)
    doc <- paste0(txt, collapse="\n")
  }

  compact <- if (compact) "true" else "false"
  trim <- if (trim) "true" else "false"
  nativeType <- if (nativeType) "true" else "false"
  addParent <- if (addParent) "true" else "false"
  alwaysArray <- if (alwaysArray) "true" else "false"
  alwaysChildren<- if (alwaysChildren) "true" else "false"
  instructionHasAttributes<- if (instructionHasAttributes) "true" else "false"
  ignoreDeclaration <- if (ignoreDeclaration) "true" else "false"
  ignoreInstruction <- if (ignoreInstruction) "true" else "false"
  ignoreAttributes<- if (ignoreAttributes) "true" else "false"
  ignoreComment <- if (ignoreComment) "true" else "false"
  ignoreCdata <- if (ignoreCdata) "true" else "false"
  ignoreDoctype <- if (ignoreDoctype) "true" else "false"
  ignoreText<- if (ignoreText) "true" else "false"

  js_param <- sprintf(
    "{
spaces: %s,
compact : %s,
trim : %s,
nativeType : %s,
addParent : %s,
alwaysArray : %s,
alwaysChildren : %s,
instructionHasAttributes : %s,
ignoreDeclaration : %s,
ignoreInstruction : %s,
ignoreAttributes : %s,
ignoreComment : %s,
ignoreCdata : %s,
ignoreDoctype : %s,
ignoreText : %s
}", spaces, compact, trim, nativeType, addParent, alwaysArray,
    alwaysChildren, instructionHasAttributes, ignoreDeclaration,
    ignoreInstruction, ignoreAttributes, ignoreComment,
    ignoreCdata, ignoreDoctype, ignoreText
  )

  js_param <- gsub("\n", " ", js_param)

  if (length(.pkgenv$ctx) == 0) {
    ctx <- V8::v8()
    ctx$source(system.file("js/bundle.js", package="blackmagic"))
    assign("ctx", ctx, envir=.pkgenv)
  }

  .pkgenv$ctx$call("incant.xml2json", doc, JS(js_param))

}
