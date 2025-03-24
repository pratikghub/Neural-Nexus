## Project Title**: Neural Network Hyperparameter Tuning for Flight Delay Classification

### Author**: Pratik Ganguli  


## Overview
This project applies **Neural Network tuning** using **tidymodels** to classify flight delays based on historical flight and weather data. The primary objective is to **optimize hyperparameters** (hidden units and epochs) to improve classification performance. We use **cross-validation, ROC analysis, and grid search tuning** to determine the best model configuration.

The dataset includes flight records from New York City airports in 2013 and incorporates weather data to predict whether a flight will arrive **more than 30 minutes late**.

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Dataset](#dataset)
- [Project Objectives](#project-objectives)
- [Methodology](#methodology)
- [Neural Network Model](#neural-network-model)
- [Hyperparameter Tuning](#hyperparameter-tuning)
- [Evaluation Metrics](#evaluation-metrics)
- [Results and Insights](#results-and-insights)
- [Business Applications](#business-applications)
- [Usage](#usage)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Requirements
To run this project, install the following R packages:
```r
install.packages(c("tidymodels", "themis", "nycflights13", "nnet", "NeuralNetTools"))
```
Additionally, ensure you have **R (>= 4.0)** and **RStudio** installed.

## Dataset
- **Source**: `nycflights13` dataset (flights departing from NYC in 2013)
- **Target Variable**: `arr_delay` (binary classification: "late" if ≥30 mins, "on_time" otherwise)
- **Predictors**:
  - Date & time features (day of the week, month)
  - Departure time
  - Weather conditions at origin
  - Other relevant flight attributes

## Project Objectives
1. **Preprocess flight and weather data** to prepare for machine learning.
2. **Train a Neural Network model** using the `tidymodels` framework.
3. **Tune hyperparameters** (hidden units and epochs) to optimize performance.
4. **Evaluate model performance** using cross-validation and ROC analysis.
5. **Visualize tuning results** to select the best model configuration.

## Methodology
### 1. Data Preprocessing
- Convert `arr_delay` into a **binary factor** (`late` vs. `on_time`).
- Extract **date-based features** (day of the week, month) using `step_date()`.
- Normalize numeric predictors using `step_normalize()`.
- Create dummy variables for categorical features using `step_dummy()`.
- Address class imbalance with `step_upsample()`.

### 2. Data Splitting
- Split dataset **80% training / 20% testing** using `initial_split()`.
- Create **cross-validation folds (v = 5)** for model tuning.

### 3. Neural Network Model Definition
- **Base Model:** `mlp(hidden_units = tune(), epochs = tune())`
- **Engine:** `nnet` (single-layer feedforward neural network)
- **Mode:** Classification
- **Workflow:** Combines model and preprocessing recipe.

## Neural Network Model
- **Architecture**:
  - **Input layer**: Encodes flight features (departure time, weather, etc.)
  - **Hidden layer**: Number of nodes (`hidden_units`) is optimized
  - **Output layer**: Predicts `late` or `on_time`
- **Activation Function**: Sigmoid (for classification)
- **Optimization**: Stochastic Gradient Descent (SGD)
- **Loss Function**: Cross-Entropy Loss

## Hyperparameter Tuning
We tune:
- **Hidden Units (`hidden_units`)**: Controls model complexity.
- **Epochs (`epochs`)**: Number of training passes through data.

### Grid Search Strategy
- Define parameter grid with `grid_regular()`.
- Use **cross-validation** (`vfold_cv()`) to compare configurations.
- Evaluate model performance using `tune_grid()`.

## Evaluation Metrics
- **Accuracy**: Overall classification correctness.
- **ROC AUC**: Measures model discrimination ability.
- **Sensitivity & Specificity**: Balance between false positives and false negatives.
- **Balanced Accuracy**: Accounts for class imbalance.

## Results and Insights
### 1. Cross-Validation Performance
- **Higher hidden units improve performance**, but diminishing returns exist.
- **Optimal epochs** balance training efficiency and overfitting.
- **Best Model**: Achieved highest **ROC AUC** with `hidden_units = 10`, `epochs = 50`.

### 2. ROC Curve Analysis
- Plotted using `roc_curve()` for different parameter values.
- Helps visualize trade-offs between sensitivity and specificity.

### 3. Tuning Visualization
- **Heatmap of Accuracy vs. Hidden Units & Epochs**
- **ROC Curves for Multiple Configurations**
- **Feature Importance Analysis**

## Business Applications
- **Predictive Scheduling**: Airlines can anticipate late arrivals and adjust schedules.
- **Customer Experience**: Proactively inform passengers of delays.
- **Resource Allocation**: Optimize staffing and runway usage based on delay probabilities.

## Usage
To reproduce results:
```r
# Load libraries
library(tidymodels)
library(nnet)
library(NeuralNetTools)

# Preprocess Data
flights_rec <- recipe(arr_delay ~ ., data = train_data) |>
  step_date(date, features = c("dow", "month")) |>
  step_normalize(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_upsample(arr_delay)

# Define Neural Network model
nn_model_tune <- mlp(hidden_units = tune(), epochs = tune()) |>
  set_engine("nnet") |>
  set_mode("classification")

# Create workflow
nn_tune_wkflow <- workflow() |>
  add_model(nn_model_tune) |>
  add_recipe(flights_rec)

# Perform hyperparameter tuning
flights_res <- nn_tune_wkflow |>
  tune_grid(resamples = flights_folds, grid = nn_grid, metrics = flights_metric)
```

## License
This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
Special thanks to **The University of Auckland** for providing resources and guidance in machine learning and analytics.


