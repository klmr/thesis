# Command line tools don’t want to clutter their output with unnecessary noise.
library = function (...)
    suppressMessages(base::library(...))

#' The command line arguments
args = commandArgs(trailingOnly = TRUE)

#' The name of the script
#'
#' @note If the script was invoked interactively, this is the empty string.
script_name = local({
    file = grep('^--file=', commandArgs(trailingOnly = FALSE), value = TRUE)
    sub('--file=', '', file)
})

#' Quit the program
#'
#' @param code numeric exit code (default: \code{0})
exit = function (code = 0)
    quit(save = 'no', status = if (is.null(code)) 0 else code)

#' Execute the \code{entry_point} function defined by the caller
#'
#' Execute an entry point function, but only if the calling code is executed as
#' a stand-alone script, not when it is imported as a module.
#'
#' @param entry_point code or function to run (default: \code{main})
#' @return This function is called for its side-effect. If the calling code was
#' imported as a module, then return nothing. Otherwise, this function
#' \emph{does not return}; instead, it quits the script.
#'
#' @details The argument may either be a function (the default is assumed to be
#' a function called \code{main} in the calling code’s scope) or a
#' brace-enclosed expression. It is executed in the calling code’s scope.
#'
#' @examples
#' \dontrun{
#' main = function () { … }
#' # Run function `main`
#' sys$run()
#'
#' # Run the specified function
#' sys$run(function () { … })
#'
#' # Run the specified code
#' sys$run({ … })
#' }
run = function (entry_point = main) {
    caller = parent.frame()
    caller_name = evalq(modules::module_name(), envir = caller)

    if (is.null(caller_name)) {
        if (class(substitute(entry_point)) == '{')
            exit(entry_point)

        exit(eval(substitute(main(), list(main = entry_point)), envir = caller))
    }
}
