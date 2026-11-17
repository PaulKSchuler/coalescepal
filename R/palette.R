#' Coalesce Lab colours
#'
#' Named colours based on the Coalesce Lab logo. `coalesce_brand` holds the
#' three logo colours. `coalesce_all` adds teal, rust and lavender, plus ochre
#' and cream (deeper and lighter versions of sand, used in the print mode).
#'
#' @format Named character vectors of hex colours.
#' @name coalesce_colours
NULL

#' @rdname coalesce_colours
#' @export
coalesce_brand <- c(navy = "#1F2370", sand = "#DBBE83", salmon = "#F3AB92")

#' @rdname coalesce_colours
#' @export
coalesce_all <- c(
  navy     = "#1F2370",  # logo
  sand     = "#DBBE83",  # logo
  salmon   = "#F3AB92",  # logo
  teal     = "#1B7F8A",  # cool contrast, not in the logo
  rust     = "#8A3324",  # deep salmon
  lavender = "#B9BBD8",  # light navy tint
  ochre    = "#B8923A",  # deep sand (print mode)
  cream    = "#F3E6C8"   # light sand (print mode)
)

#' Discrete Coalesce palette
#'
#' @param n Number of colours, 2 to 6.
#' @param mode One of
#'   * `"logo"` (default): navy, sand, salmon, teal, rust, lavender.
#'   * `"screen"`: logo colours, never sand and salmon as two separate series
#'     (colour-blind safe, up to 5 colours; the 6-colour set still contains both).
#'   * `"print"`: deeper variants that are also distinct in black and white.
#'
#' @details Sand and salmon look almost identical with red-green colour
#'   blindness and print as the same grey. Whenever a figure uses both, add a
#'   second cue such as [coalesce_shapes], an outline or direct labels. The
#'   warning can be silenced with `options(coalesce.quiet = TRUE)`.
#'
#' @return A character vector of `n` hex colours.
#' @examples
#' coalesce_pal(4)
#' coalesce_pal(4, "print")
#' @export
coalesce_pal <- function(n, mode = c("logo", "screen", "print")) {
  mode <- match.arg(mode)
  if (!n %in% 2:6) stop("coalesce_pal() supports 2 to 6 colours", call. = FALSE)
  idx <- switch(
    mode,
    logo = c("navy", "sand", "salmon", "teal", "rust", "lavender")[seq_len(n)],
    screen = switch(
      as.character(n),
      "2" = c("navy", "salmon"),
      "3" = c("navy", "salmon", "teal"),
      "4" = c("navy", "sand", "teal", "rust"),
      "5" = c("navy", "sand", "lavender", "teal", "rust"),
      "6" = c("navy", "sand", "lavender", "teal", "rust", "salmon")
    ),
    print = switch(
      as.character(n),
      "2" = c("navy", "ochre"),
      "3" = c("navy", "teal", "ochre"),
      "4" = c("navy", "rust", "teal", "ochre"),
      "5" = c("navy", "rust", "teal", "ochre", "lavender"),
      "6" = c("navy", "rust", "teal", "ochre", "lavender", "cream")
    )
  )
  if (all(c("sand", "salmon") %in% idx) && mode != "print" &&
      !isTRUE(getOption("coalesce.quiet"))) {
    warning("Sand and salmon look alike with red-green colour blindness and in ",
            "greyscale. Add a shape, an outline or direct labels. ",
            "Silence with options(coalesce.quiet = TRUE).", call. = FALSE)
  }
  unname(coalesce_all[idx])
}

#' Point shapes to pair with the colours
#'
#' Filled shapes (circle, square, triangle, diamond, inverted triangle).
#' @export
coalesce_shapes <- c(21, 22, 24, 23, 25, 21)

#' Continuous ramps
#'
#' `coalesce_seq`: light to navy. `coalesce_seq_warm`: cream to rust.
#' `coalesce_div`: navy, light grey, terracotta (low, mid, high).
#' @name coalesce_ramps
NULL

#' @rdname coalesce_ramps
#' @export
coalesce_seq <- c("#EEF0F8", "#8B90CC", "#1F2370")

#' @rdname coalesce_ramps
#' @export
coalesce_seq_warm <- c("#F3E6C8", "#B8923A", "#8A3324")

#' @rdname coalesce_ramps
#' @export
coalesce_div <- c(low = "#1F2370", mid = "#F7F7F7", high = "#C4603F")

# Internal: scales need ggplot2, which is only suggested
need_ggplot2 <- function() {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required for the scale functions.", call. = FALSE)
  }
}

#' ggplot2 scales
#'
#' @param n Number of categories (2 to 6).
#' @param mode Palette mode, see [coalesce_pal()].
#' @param midpoint Midpoint of the diverging scale.
#' @param ... Passed on to the underlying ggplot2 scale.
#' @name scale_coalesce
NULL

#' @rdname scale_coalesce
#' @export
scale_colour_coalesce <- function(n, mode = "logo", ...) {
  need_ggplot2()
  ggplot2::scale_colour_manual(values = coalesce_pal(n, mode), ...)
}

#' @rdname scale_coalesce
#' @export
scale_fill_coalesce <- function(n, mode = "logo", ...) {
  need_ggplot2()
  ggplot2::scale_fill_manual(values = coalesce_pal(n, mode), ...)
}

#' @rdname scale_coalesce
#' @export
scale_shape_coalesce <- function(n, ...) {
  need_ggplot2()
  ggplot2::scale_shape_manual(values = coalesce_shapes[seq_len(n)], ...)
}

#' @rdname scale_coalesce
#' @export
scale_fill_coalesce_seq <- function(...) {
  need_ggplot2()
  ggplot2::scale_fill_gradientn(colours = coalesce_seq, ...)
}

#' @rdname scale_coalesce
#' @export
scale_fill_coalesce_div <- function(midpoint = 0, ...) {
  need_ggplot2()
  ggplot2::scale_fill_gradient2(low = coalesce_div[["low"]], mid = coalesce_div[["mid"]],
                                high = coalesce_div[["high"]], midpoint = midpoint, ...)
}
