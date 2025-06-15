## Title: An Analysis of Customer Churn Prediction Using Classification Models with K-Folds Cross Validation
### Author: Pratik Ganguli

## Overview

This project aims to predict customer churn using a variety of machine learning models, including Logistic Regression, k-Nearest Neighbors (k-NN), Random Forest, XGBoost, and LightGBM. The dataset contains information about customer behaviors and demographics, and the goal is to identify whether a customer will churn (leave the company) based on this information.

The project uses k-fold cross-validation to assess the performance of each model and evaluate its robustness. A variety of performance metrics are used to ensure accurate and reliable predictions.


## Table of Contents
1.	[Dataset Overview](#DatasetOverview)
2.	[Data Preprocessing](#DataPreprocessing)
3.	[Modeling](#Modeling)
4.	[Evaluation Metrics](#EvaluationMetrics)
5.	[Cross-Validation](#Cross-Validation)
6.	[Results](#Results)
7.	[Conclusions](#Conclusions)
8.	[Requirements](#Requirements)
9.	[License](#License)


## 1. Dataset Overview

The dataset consists of various customer features, including:
	•	Demographic information (e.g., age, gender)
	•	Customer behavior (e.g., usage patterns, service plan)
	•	Churn status (target variable: 1 if churned, 0 if not)

The data is split into training and testing sets, and multiple models are trained and evaluated to predict customer churn.


## 2. Data Preprocessing

Before feeding the data into the models, the following preprocessing steps were performed:
	1.	Handling Missing Data: Missing values were imputed using appropriate techniques such as mean or median imputation.
	2.	Encoding Categorical Variables: Categorical variables were encoded using one-hot encoding or label encoding, depending on the model requirements.
	3.	Feature Scaling: Numerical features were scaled using standardization (z-score normalization) to ensure all features are on the same scale, especially for distance-based algorithms like k-NN.
	4.	Feature Selection: Unimportant features were removed to enhance model performance and reduce complexity.


## 3. Modeling

Five different machine learning models were trained and evaluated:
	1.	Logistic Regression: A simple linear model that works well for binary classification tasks.
	2.	k-Nearest Neighbors (k-NN): A non-parametric model that predicts the class based on the majority class among the k nearest data points.
	3.	Random Forest: An ensemble learning method that builds multiple decision trees and combines their predictions for improved accuracy.
	4.	XGBoost: An optimized gradient boosting method that is known for high performance in structured data tasks.
	5.	LightGBM: A gradient boosting framework that is faster and more efficient for large datasets compared to other boosting methods.

Each model was evaluated using 10-fold cross-validation to ensure robust performance and prevent overfitting.


## 4. Evaluation Metrics

The models were evaluated using the following metrics:
	•	Accuracy: The proportion of correct predictions (both churn and non-churn).
	•	AUC (Area Under the Curve): A measure of the model’s ability to distinguish between the classes.
	•	Precision: The proportion of true positive predictions among all positive predictions.
	•	Recall (Sensitivity): The proportion of true positive predictions among all actual positives.
	•	Specificity: The proportion of true negative predictions among all actual negatives.

These metrics provide a comprehensive understanding of how well the models perform on the given task.


## 5. Cross-Validation

10-Fold Cross-Validation was used to evaluate the models:
	1.	Data Splitting: The dataset was divided into 10 equal folds. Each fold was used once as a validation set while the remaining 9 folds were used for training.
	2.	Stratification: Stratified sampling was applied to maintain a consistent distribution of churned and non-churned customers in both the training and validation sets.
	3.	Performance Evaluation: Each model was evaluated on every fold, and the results were averaged to provide a final assessment of model performance.

This method ensures that the evaluation results are reliable and less biased, as each data point is used for both training and validation.


## 6. Results

The following table shows the average performance metrics for each model across all 10 folds:

| Model            | Accuracy | AUC  | Precision | Recall | Specificity |
|------------------|----------|------|-----------|--------|-------------|
| Logistic Reg.    | 0.82     | 0.75 | 0.80      | 0.70   | 0.85        |
| k-NN             | 0.78     | 0.74 | 0.78      | 0.68   | 0.83        |
| Random Forest    | 0.85     | 0.80 | 0.82      | 0.75   | 0.88        |
| XGBoost          | 0.87     | 0.84 | 0.85      | 0.78   | 0.90        |
| LightGBM         | 0.88     | 0.85 | 0.86      | 0.80   | 0.91        |


## 7. Conclusions

•	LightGBM emerged as the best-performing model with the highest accuracy, AUC, and specificity, followed closely by XGBoost.
•	Random Forest also performed well, offering a balance of precision and recall, making it a good choice for handling imbalanced classes.
•	Logistic Regression and k-NN had relatively lower performance, particularly in terms of recall and AUC, suggesting they may not be as effective for this particular classification task.

In conclusion, for this churn prediction problem, LightGBM and XGBoost are the top contenders, providing strong predictive performance with high AUC and accuracy. These models are recommended for deployment in real-world scenarios.


## 8. Requirements

To run this analysis, ensure you have the following:
	•	R (version 4.0 or higher)

R Libraries:
	•	data.table — For efficient data handling and manipulation.
	•	caret — For model training, cross-validation, and evaluation.
	•	xgboost — For training the XGBoost model.
	•	lightgbm — For training the LightGBM model.
	•	randomForest — For training the Random Forest model.
	•	knn — For k-Nearest Neighbors implementation.
	•	e1071 — For training the Support Vector Machine (SVM) model.
	•	pROC — For AUC calculations and ROC curve plotting.
	•	ggplot2 — For visualization and plotting.
	•	dplyr — For data manipulation and transformation.
	•	tidyr — For data tidying and preprocessing.

To install these libraries, you can run the following R commands:

	install.packages(c("data.table", "caret", "xgboost", "lightgbm", "randomForest", "knn", "e1071", "pROC", "ggplot2", "dplyr", "tidyr"))


## 9. License

This project is licensed under the MIT License.



## 10. Acknowledgments

- This project was completed as part of a Master’s program project at the [University of Auckland](https://www.auckland.ac.nz/en.html). Special thanks to the University of Auckland for the opportunity to undertake this project and for their invaluable support.

## Other Tools:

Power BI: For dashboard creation.
Datasets: Access the 25 datasets listed below.

## Dataset & Source References

### 🎬 IMDB & OTT Platforms
- **IMDB OTT Platforms Movies (Power BI Dashboard)**  
  Motiani, Y. (n.d.). *IMDB OTT Platforms Movies (Power BI Dashboard)*. [Kaggle](https://www.kaggle.com/datasets/yashmotiani/imdb-ott-platforms-movies-power-bi-dashboard)

- **IMDb Non-Commercial Datasets**  
  IMDb. (n.d.). *IMDb Non-Commercial Datasets*. [IMDb Developer](https://developer.imdb.com/non-commercial-datasets/)

- **IMDB Dataset**  
  Amanat, P. (n.d.). *IMDB Dataset*. [Kaggle](https://www.kaggle.com/datasets/payamamanat/imbd-dataset)

### 📺 Streaming Services – Multi-platform
- **Movies on Netflix, Prime Video, Hulu and Disney**  
  Ruchi798. (n.d.). *Movies on Netflix, Prime Video, Hulu and Disney*. [Kaggle](https://www.kaggle.com/datasets/ruchi798/movies-on-netflix-prime-video-hulu-and-disney)

- **OTT Video Streaming Platforms Revenue and Users**  
  Wasi, A. T. (n.d.). *OTT Video Streaming Platforms Revenue and Users*. [Kaggle](https://www.kaggle.com/datasets/azminetoushikwasi/ott-video-streaming-platforms-revenue-and-users)

- **Netflix OTT Revenue and Subscribers CSV File**  
  Mauryans, S. (n.d.). *Netflix OTT Revenue and Subscribers CSV File*. [Kaggle](https://www.kaggle.com/datasets/mauryansshivam/netflix-ott-revenue-and-subscribers-csv-file)

### Netflix-Specific
- **Netflix Movies and TV Shows Clustering**  
  Bansode, S. (n.d.). *Netflix Movies and TV Shows Clustering*. [Kaggle](https://www.kaggle.com/code/bansodesandeep/netflix-movies-and-tv-shows-clustering)

- **Netflix Original Films IMDb Scores**  
  Corter, L. (n.d.). *Netflix Original Films IMDb Scores*. [Kaggle](https://www.kaggle.com/datasets/luiscorter/netflix-original-films-imdb-scores)

- **Netflix Originals CSV**  
  PrasertCB. (n.d.). *NetflixOriginals.csv*. [GitHub](https://github.com/prasertcbs/basic-dataset/blob/master/NetflixOriginals.csv)

- **Netflix Customer Churn and Engagement Dataset**  
  Dddtra. (n.d.). *Netflix Customer Churn and Engagement Dataset*. [Kaggle](https://www.kaggle.com/datasets/dddtra/netflix-customer-churn-and-engagement-dataset)

- **Netflix Engagement Report**  
  Konradb. (n.d.). *Netflix Engagement Report*. [Kaggle](https://www.kaggle.com/datasets/konradb/netflix-engagement-report/data)

- **Netflix Reviews (Play Store, Daily Updated)**  
  Ashishkumarak. (n.d.). *Netflix Reviews (Play Store, Daily Updated)*. [Kaggle](https://www.kaggle.com/datasets/ashishkumarak/netflix-reviews-playstore-daily-updated)

### Other Platforms
- **Paramount Movies and TV Shows**  
  Goenrique, D. (n.d.). *Paramount Movies and TV Shows*. [Kaggle](https://www.kaggle.com/datasets/dgoenrique/paramount-movies-and-tv-shows)

- **Apple TV Movies and TV Shows**  
  Goenrique, D. (n.d.). *Apple TV Movies and TV Shows*. [Kaggle](https://www.kaggle.com/datasets/dgoenrique/apple-tv-movies-and-tv-shows)

- **Full HBO Max Dataset**  
  Octopus Team. (n.d.). *Full HBO Max Dataset*. [Kaggle](https://www.kaggle.com/datasets/octopusteam/full-hbo-max-dataset)

### General Statistics
- **Netflix User Statistics**  
  Dean, B. (n.d.). *Netflix User Statistics*. [Backlinko](https://backlinko.com/netflix-users)

- **Netflix Statistics**  
  Business of Apps. (n.d.). *Netflix Statistics*. [Business of Apps](https://www.businessofapps.com/data/netflix-statistics/?utm_source=chatgpt.com)

