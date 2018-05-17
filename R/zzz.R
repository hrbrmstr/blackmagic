.pkgenv <- new.env(parent=emptyenv())

.onAttach <- function(libname, pkgname) {

  ctx <- V8::v8()
  ctx$source(system.file("js/bundle.js", package="blackmagic"))
  assign("ctx", ctx, envir=.pkgenv)

}
