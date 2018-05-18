context("Parses character, xml2 and XML package docs")
test_that("we parse character, xml2 and XML package docs", {

  xml <- '<?xml version="1.0" encoding="utf-8"?><note importance="high"><title>Happy</title></note>'

  expect_equal(
    abbreviate(xml_to_json(xml), minlength=50, method = "both.sides", named=FALSE),
    "{\"\":{\"\":{\"\":\"1.0\",\"\":\"-8\"}},\"\":[{\"\":\"\",\"\":\"\",\"\":{\""
  )

  expect_equal(
    abbreviate(xml_to_json(xml2::read_xml(xml)), minlength=50, method = "both.sides", named=FALSE),
    "{\"\":{\"\":{\"\":\"1.0\",\"\":\"UTF-8\"}},\"\":[{\"\":\"\",\"\":\"\",\"\""
  )

  expect_equal(
    abbreviate(xml_to_json(XML::xmlParse(xml)), minlength=50, method = "both.sides", named=FALSE),
    "{\"\":{\"\":{\"\":\"1.0\",\"\":\"-8\"}},\"\":[{\"\":\"\",\"\":\"\",\"\":{\""
  )

})

context("Parses character JSON to XML")
test_that("we parse character JSON docs", {

  json <- '{ "a" : 1 }'

  expect_equal(
    json_to_xml(json),
    "<a>1</a>"
  )
})

context("Parses JSON or XML from a URL")
test_that("we can parse stuff from a URL", {

  testthat::skip_on_cran()

  expect_equal(
    abbreviate(xml_to_json("https://httpbin.org/xml"), minlength=50, method = "both.sides", named=FALSE),
    "{\"\":{\"\":{\"\":\"1.0\",\"\":\"-\"}}ASsos\"SSopTTS\"utWO\"\"ag\"W"
  )

  expect_true(
    grepl("uuid", json_to_xml("https://httpbin.org/uuid", spaces=2))
  )

})
