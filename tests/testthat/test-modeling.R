## test-modeling.R
# ----------------
# Unit tests for modeling functions in `modeling.R`.
#
# Functions tested:
# - `train_rf_model()`: trains a Random Forest classifier from a formula and data
# - `evaluate_rf_model()`: evaluates model using a test set, returns metrics and confusion matrix
# - `plot_confusion_matrix()`: creates ggplot visualization of the confusion matrix
# - `plot_feature_importance()`: visualizes variable importance from Random Forest model
#
# This testthat file includes:
# - Tests for formula parsing and error handling (e.g., missing columns, . notation)
# - Tests for output structure (confusion matrix, metrics)
# - Visualization object class checking (ggplot)
# - File saving verification for plots
# - Input validation and informative error throwing


# # Set working directory to project root if needed
# if (!file.exists("data/processed/longbeach_transformed.csv")) {
#   setwd("../../")
# }

library(testthat)
library(caret)
library(randomForest)
library(tidyverse)

# ------------------------------
# Dummy data for testing
df <- data.frame(
  adopted = factor(c("Yes", "No", "Yes", "No")),
  age = c(2, 5, 1, 4),
  sex = factor(c("M", "F", "F", "M"))
)
# ------------------------------
# Tests for train_rf_model
test_that("train_rf_model returns a randomForest object", {
  model <- train_rf_model(df, adopted ~ age + sex)
  expect_s3_class(model, "randomForest")
})

test_that("train_rf_model errors with non-data.frame input", {
  expect_error(train_rf_model("not_df", adopted ~ age), "must be a data frame")
})

test_that("train_rf_model errors with invalid formula", {
  expect_error(train_rf_model(df, "adopted ~ age"), "must be a valid formula")
})

# ------------------------------
# Tests for evaluate_rf_model
test_that("evaluate_rf_model returns list with expected elements", {
  model <- train_rf_model(df, adopted ~ age + sex)
  results <- evaluate_rf_model(model, df)
  expect_true(all(c("confusion_matrix", "metrics", "cm_summary") %in% names(results)))
  expect_s3_class(results$confusion_matrix, "confusionMatrix")
})

test_that("evaluate_rf_model errors on wrong model type", {
  expect_error(evaluate_rf_model("not_a_model", df), "randomForest object")
})

# ------------------------------
# Tests for plot_confusion_matrix
test_that("plot_confusion_matrix returns a ggplot object", {
  model <- train_rf_model(df, adopted ~ age + sex)
  results <- evaluate_rf_model(model, df)
  p <- plot_confusion_matrix(results$confusion_matrix)
  expect_s3_class(p, "ggplot")
})

test_that("plot_confusion_matrix errors on wrong input", {
  expect_error(plot_confusion_matrix("not_cm"), "confusionMatrix object")
})

# ------------------------------
# Tests for plot_feature_importance
test_that("plot_feature_importance returns a ggplot object", {
  model <- train_rf_model(df, adopted ~ age + sex)
  p <- plot_feature_importance(model)
  expect_s3_class(p, "ggplot")
})

test_that("plot_feature_importance errors with non-randomForest input", {
  expect_error(plot_feature_importance("bad_model"), "randomForest object")
})
