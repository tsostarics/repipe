
<!-- README.md is generated from README.Rmd. Please edit that file -->

# repipe

<!-- badges: start -->
<!-- badges: end -->

This is a simple add in for RStudio to change magrittr `%>%` pipes to
native pipes `|>` where possible. You can highlight a region of text,
then use the `repipe` command from the command pane (`Ctrl+Shift+P`).
This is accomplished through a single regular expression substitution.

One reason you might want to do this is to make an existing pipeline
faster by taking advantage of `|>` being done at the parser level while
retaining functionality that `%>%` provides *when it’s needed*. In most
casual cases it’s probably already fast enough, but this may eke out a
little bit more speed in some settings.

There are some edge cases where this doesn’t work right now:

-   `x %>% foo("(.)")` will keep the magrittr pipe due to `.)` embedded
    in a string in the RHS

but for simple pipelines it should work well enough. This is mostly for
my own use but if others find it helpful and would like to tweak it
that’s also great.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("tsostarics/repipe")
```

## Example

``` r
library(tidyverse)
mtcars %>% 
  tibble::as_tibble(rownames = "car") %>% 
  group_by(cyl) %>% 
  filter(gear > 4) %>% 
  .$car %>% 
  grepl("Ford", .) %>% 
  sum()
#> [1] 1
```

You can select the above region and run `repipe` to change *only* the
pipes that can be changed to native pipes. Pipes that are complemented
by `.` in the right hand side will remain as magrittr pipes.

``` r
mtcars |> 
  tibble::as_tibble(rownames = "car") |> 
  group_by(cyl) |> 
  filter(gear > 4) %>% 
  .$car %>% 
  grepl("Ford", .) |> 
  sum()
#> [1] 1
```

## Future improvements

Future improvements could include changing the remaining `%>%`s into
native pipes and reworking the `.` to utilize the new lambda syntax:

``` r
mtcars |> 
  tibble::as_tibble(rownames = "car") |> 
  group_by(cyl) |> 
  filter(gear > 4) |>
  {\(x) x$car}() |>
  {\(x) grepl("Ford", x)}() |> 
  sum()
#> [1] 1
```

Another possibility would be to break up nested commands into a pipeline
such as `exp(length(colnames(mtcars)))` into
`mtcars |> colnames() |> length() |> exp()` but this may exist elsewhere
already.
