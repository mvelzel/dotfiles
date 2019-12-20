#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  stop("Missing file argument.")
}

library(styler)
style_file(args[1])
