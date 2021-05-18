#' Repipe
#'
#' Replaces magrittr pipes in a highlighted region with native pipes where
#' possible. Does not replace pipes that are followed by a usage of . to
#' reference the piped value
#'
#'
#' @export
repipe <- function(){
  source_context <- rstudioapi::getSourceEditorContext()
  rstudioapi::modifyRange(
    text = .change_pipe_text(source_context[['selection']][[1L]][['text']])
  )
}

.change_pipe_text <- function(text_selection){
  gsub("%>%(?!\\w)(?![^%]*(\\.[ $[)]|, \\.))", "\\|>",
       text_selection,
       perl = TRUE)
}
