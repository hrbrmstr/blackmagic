context("minimal package functionality")
test_that("we can do something", {

  xml <- '<?xml version="1.0" encoding="utf-8"?><note importance="high"><title>Happy</title></note>'

  expect_equal(
    abbreviate(xml_to_json(xml), minlength=50, method = "both.sides", named=FALSE),
    "{\"\":{\"\":{\"\":\"1.0\",\"\":\"-8\"}},\"\":[{\"\":\"\",\"\":\"\",\"\":{\""
  )

})
