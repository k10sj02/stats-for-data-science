# Statistics for Data Science

## Course Description
Explored fundamental statistical concepts, including manipulating and cleaning different data types, inference sampling, probabilistic conclusions, and hypothesis testing to validate findings. I implemented both simple and multivariable linear regression, with a particular emphasis on distinguishing their applications in statistics vs. machine learning. Additionally, I gained mastery in A/B testing concepts throughout the course. All concepts were actively applied using the open-source software R.

### Assignments

**Assigment 1: **

This script facilitates data analysis and manipulation tasks using R. It begins by retrieving the current working directory and installing/loading necessary packages including readr, xlsx, readxl, and tidyverse. The dataset, sourced from an Excel file, is loaded and named. It then conducts various analyses, such as determining the count of male and female individuals, computing the average age, and aggregating data by student status and gender to derive mean SAT scores and newspaper readership frequency, respectively. Additionally, it provides a summary of the dataset and showcases manual data entry and manipulation techniques, including filtering based on gender.

**Assignment 2: **

This script collection encompasses diverse statistical analyses and visualizations using the `iris` dataset, including scatter plot matrices, correlation matrices, and regression models. Additionally, it demonstrates two-sample t-tests through custom and built-in functions, computes probabilities using the standard normal distribution, and conducts statistical tests to evaluate IQ score improvements post-training. The scripts serve as a comprehensive resource for statistical analysis and hypothesis testing in R.

**Assignment 3: **

This script conducts statistical analysis on weight gain data from two groups, high-protein and low-protein diets. It calculates means and standard deviations for each group, performs a two-sample t-test to compare weight gains between the groups, and assesses normality assumptions using Shapiro-Wilk tests and visual inspection. The analysis is followed by a paired t-test on paired data from 'immer' dataset, examining the difference in weight gains between two time points. Results are stored for further analysis. The script provides a systematic approach to data analysis and hypothesis testing in R.

**Assignment 4: **

The script begins by loading the `iris` dataset and summarizes its structure and dimensions. It then proceeds to create random training, validation, and test sets manually, specifying the proportions for each. Following this, data partitioning using the `caret` package is demonstrated, where training and validation datasets are created using the `createDataPartition` function. 

The script transitions to a business optimization case, utilizing the `lpSolveAPI` package to maximize profit from laptop and desktop production. Constraints such as minimum and maximum production limits are set, followed by solving the problem and extracting optimized production values. Ultimately, the script concludes with the optimal daily production recommendation: 1200 laptops and 800 desktops to achieve a maximum profit of $960,000.

**Assignment 5: **

The script sets up the environment by loading essential packages like xlsx, QuantPsyc, olsrr, and car, then proceeds to cleanse imported data by removing empty rows and converting variables to numeric for regression analysis. It modifies column names for clarity before delving into regression analysis. Two regression models (heating_load and cooling_load) are built and assessed for adherence to assumptions such as linearity, homoscedasticity, independence, and normality through diagnostic plots and statistical tests. Multicollinearity is evaluated using the Variance Inflation Factor (VIF). The script offers a comprehensive approach to data preprocessing and regression diagnostics, ensuring robust model interpretation and validity.

