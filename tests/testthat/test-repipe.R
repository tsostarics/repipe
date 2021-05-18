test_that("repiping works", {
  tst <- "df %>%
  group_by(my.groups) %>%
  filter(this.col == \"bad.news\") %>%
  .$new.col %>%
  grepl(\"has.dots...\", .) %>%
  paste(collapse = \" \") %>%
  .[['more.dots']] %>%
  foo(...=~ .) %>%
  sum() |>
  exp() %>% plogis() %>% grepl(\"text\", .) %>%
  .exp()"

  rslt <- "df |>
  group_by(my.groups) |>
  filter(this.col == \"bad.news\") %>%
  .$new.col %>%
  grepl(\"has.dots...\", .) |>
  paste(collapse = \" \") %>%
  .[['more.dots']] %>%
  foo(...=~ .) |>
  sum() |>
  exp() |> plogis() %>% grepl(\"text\", .) |>
  .exp()"

  expect_equal(.change_pipe_text(tst), rslt)
})
