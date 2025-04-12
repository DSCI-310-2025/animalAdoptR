<!-- [![Pkgdown site](https://img.shields.io/badge/docs-pkgdown-blue)](https://dsci-310-2025.github.io/animalAdoptR/) -->

<!-- badges: start -->
[![R-CMD-check](https://github.com/DSCI-310-2025/animalAdoptR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/DSCI-310-2025/animalAdoptR/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/DSCI-310-2025/animalAdoptR/actions/workflows/pkgdown.yaml/badge.svg)](https://dsci-310-2025.github.io/animalAdoptR/)
[![Codecov test coverage](https://codecov.io/gh/DSCI-310-2025/animalAdoptR/graph/badge.svg)](https://app.codecov.io/gh/DSCI-310-2025/animalAdoptR)
<!-- badges: end -->

# animalAdoptR 

**animalAdoptR** is an R package that provides helper functions for preprocessing, visualizing, and modeling animal shelter adoption data. It was built as part of a data science course project to encourage code modularity, reproducibility, and reusability.

## Features

- Load and validate CSV datasets with informative messages
- Preprocess and group rare categories for categorical variables
- Train and evaluate random forest models
- Generate clean visualizations for adoption rates, feature importance, and confusion matrices
- Save plots and summary tables directly to file

## Installation

To install the development version of `animalAdoptR` from GitHub:

```r
# install.packages("devtools")
devtools::install_github("DSCI-310-2025/animalAdoptR")
```

**Then load the package:**
```r
library(animalAdoptR)
```

## Example Usage
```r
# Load and inspect data
df <- load_data("data/processed/longbeach_transformed.csv")

# Train a model
model <- train_rf_model(df, adopted ~ age + sex)

# Evaluate it
results <- evaluate_rf_model(model, df)

# Plot confusion matrix
plot_confusion_matrix(results$confusion_matrix)

# Plot feature importance
plot_feature_importance(model)
```

## Code of Conduct

Please note that the animalAdoptR project is released with a [Contributor Code of Conduct](https://dsci-310-2025.github.io/animalAdoptR/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.

## License
This project is licensed under the [MIT License](https://opensource.org/license/MIT).