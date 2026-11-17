# coalescepal
<img src="man/figures/logo.png" align="right" height="139" alt="coalescepal logo" />

Colours based on the Coalesce Lab logo, for R and ggplot2. Palettes for
screens, slides and black-and-white print, with a colour-blind-safe option.

![Palette](man/figures/palette.png)

## Install

The package lives on GitHub, not on CRAN, so install it from there.

```r
install.packages("remotes")   # once
remotes::install_github("PaulKSchuler/coalescepal")
```

`pak` also works, and it installs dependencies faster:

```r
install.packages("pak")
pak::pak("PaulKSchuler/coalescepal")
```

Check that it worked:

```r
library(coalescepal)
coalesce_pal(3, "screen")
#> [1] "#1F2370" "#F3AB92" "#1B7F8A"
```

**Update** by running the install line again. Add `force = TRUE` if R says the
package is already up to date but you know it changed.

**Pin a version** so figures stay identical over time:

```r
remotes::install_github("PaulKSchuler/coalescepal@v0.1.0")
```

In a project that uses `renv`, run `renv::snapshot()` after installing. This
records the exact commit, and collaborators get it back with `renv::restore()`.

<details>
<summary>Installation problems</summary>

* **`HTTP error 403` or "rate limit exceeded".** GitHub limits anonymous
  downloads. Create a token with `usethis::create_github_token()`, then run
  `usethis::edit_r_environ()` and add the line `GITHUB_PAT=your_token`.
  Restart R.
* **`Failed to install ... from GitHub`.** Read the line above that message.
  It names the cause. If it is unclear, open an issue on this repository and
  paste the full output.
* **Package installs but a function is missing.** An older copy is loaded.
  Restart R (Session > Restart R), then run `library(coalescepal)` again.
* **`ggplot2` errors.** The scale functions need ggplot2.
  Run `install.packages("ggplot2")`.

</details>

## Use

```r
library(coalescepal)
library(ggplot2)

ggplot(mpg, aes(displ, hwy, colour = drv, shape = drv)) +
  geom_point(size = 3) +
  scale_colour_coalesce(3, mode = "screen") +
  scale_shape_coalesce(3)
```

`coalesce_pal(n, mode)` returns 2 to 6 colours. The scales
`scale_colour_coalesce()` and `scale_fill_coalesce()` take the same
arguments.

## Colours

| name | hex | name | hex |
|---|---|---|---|
| navy | `#1F2370` | lavender | `#B9BBD8` |
| sand | `#DBBE83` | ochre | `#B8923A` |
| salmon | `#F3AB92` | cream | `#F3E6C8` |
| teal | `#1B7F8A` | sky | `#3FA7B3` |
| rust | `#8A3324` | coral | `#E07B5A` |

Navy, sand and salmon come from the logo. The others are deeper, lighter or
brighter variants, plus teal as a cool contrast. All ten are in
`coalesce_all`, and the three logo colours are in `coalesce_brand`.

## Modes

| mode | colours | use |
|---|---|---|
| `"logo"` (default) | navy, sand, salmon, teal, rust, lavender | posters and talks, with a second cue |
| `"screen"` | logo colours, never sand and salmon as two series | colour-blind safe, up to 5 colours |
| `"print"` | navy, rust, teal, ochre, lavender, cream | black-and-white print |
| `"slides"` | navy, sand, salmon (exact logo), sky, coral, lavender | projected slides, on white or navy |

`"screen"` gives at most five colours without sand and salmon together. At six
it adds salmon back.

**Caution.** Sand and salmon look almost identical with red-green colour
blindness and print as the same grey. When a figure uses both, add a shape
(`scale_shape_coalesce()`), an outline or direct labels. Silence the warning
with `options(coalesce.quiet = TRUE)`.

## Slides

```r
ggplot(mpg, aes(displ, hwy, colour = drv)) +
  geom_point(size = 3) +
  scale_colour_coalesce(3, mode = "slides") +
  theme_coalesce_slides("dark")
```

`theme_coalesce_slides("dark")` draws on the logo navy, and `"light"` on
white. On white, sand has little contrast, so give those points an outline.
`ppt_theme` lists the twelve PowerPoint theme colours. Enter them under
Design > Variants > Colors > Customize Colors.

## Continuous ramps

`coalesce_seq` (light to navy), `coalesce_seq_warm` (cream to rust) and
`coalesce_div` (navy, grey, terracotta), with `scale_fill_coalesce_seq()` and
`scale_fill_coalesce_div()`.

## Develop

```r
devtools::document()   # builds man/ and NAMESPACE from the roxygen comments
devtools::test()
devtools::check()
```

Licence: MIT.
