# Melanoma-Survival-Analysis Report

- [Project Overview](#project_overview)
- [Tools](#tools)
- [Data Source](#data_source)
- [Processes](#processes)
- [Results](results)
- [Recommendations and Future Direction](#recommendations_and_future_direction)

## Project Overview

This is an exploratory data analysis of the "Survival from Malignant Melanoma" dataset, focusing on identifying and evaluating prognostic factors that influence survival outcomes.The key variables such as tumor thickness, ulceration, age at operation, and gender are examined to understand their impact on patient survival and highlight patterns that may inform clinical management strategies. 

The analysis includes statistical summaries and visualizations, such as histograms, bar plots, and box plots, to illustrate distributions and trends in survival time, tumor characteristics, and demographic factors. These visuals help uncover data patterns, central tendencies, and potential outliers, setting the stage for  statistical modeling.

## Tools

- Excel
- R

## Data Source

[melanoma.csv](https://github.com/user-attachments/files/18903923/melanoma.csv)

## Processes

- Data Cleaning and Preparation
- Analysis
- Visualisation

## Results

### Graphical summaries of melanoma data

![2](https://github.com/user-attachments/assets/0af14ffb-1523-48e0-b495-be29792344c7)

The histogram above shows a skewed distribution of survival time, with a peak around 2000 days. A long tail to the right indicates that a small number of individuals survived much longer than the majority.

![ii_Patience_status](https://github.com/user-attachments/assets/b2836c4d-ed26-4590-8e6b-d57a6333dff2)

The bar plot shows that most patients stayed alive (status 2). A smaller number of patients died from melanoma (status 1), and an even smaller number died from other causes (status 3). 

![11_Gender_](https://github.com/user-attachments/assets/f62ebef8-40fb-4bc7-b791-73a39a9b0355)

![ii_age_distribution](https://github.com/user-attachments/assets/8a4788b2-c9e8-42b6-bff0-d878654f9b29)

The histogram shows a right-skewed age distribution at operation, peaking around 50-60 years old. This indicates that most patients were older adults at the time of surgery.

![3](https://github.com/user-attachments/assets/d4bfd83d-3980-4620-af06-6ff863767a7b)

The histogram shows a clear increase in operations performed over time, peaking in the early 1970s. This suggests there may have been advancements in surgical techniques or treatments during this period.

![4](https://github.com/user-attachments/assets/6bad52e7-cfcf-40e4-81d7-f8b0c0a4c0ad)

The box plot shows that most tumour thicknesses are between 0 and 4 mm, with a few outliers extending to 15 mm. This indicates that most tumours are relatively thin, but some cases have significantly thicker tumours.

### Regressional Analysis and and appropriate Correlations 

![5](https://github.com/user-attachments/assets/f78e2c39-2753-4ce4-8eb6-241ee0c17f18)

![7](https://github.com/user-attachments/assets/efd45ee6-689f-4500-9ff0-74164ffe2e6f)

![6](https://github.com/user-attachments/assets/6e64fe57-7ddf-4214-820a-2a6200050dc4)

![Screenshot 2024-09-12 010249](https://github.com/user-attachments/assets/1228b461-656a-4cc0-9674-6e3809ca30b6)

The relationship between tumour thickness and survival time is significant (p = 0.000679), with a slight negative correlation of -0.21, meaning survival time decreases as tumour thickness increases, though the impact is minimal. 

Age is also a significant predictor of survival time (p = 1.12*10^-5) with a negative correlation of -0.3, implying survival time decreases by about 20 days per added year of age, though the relationship is weak to moderate. 

The regression model shows a statistically significant relationship between age and tumour thickness (p = 0.00222), suggesting older patients tend to have slightly thicker tumours. However, the correlation of 0.21 indicates a weak relationship, so age alone doesn't strongly predict tumour thickness.


![8](https://github.com/user-attachments/assets/366e4264-7c12-4ff9-a2ec-5a21d052027e)

Survival Time by Gender: Both female and male survival times closely follow a normal distribution. The linear pattern in the QQ plot suggests that survival time is normally distributed for both genders.

Tumour Thickness by Gender: The female line shows some deviation from linearity in the middle quantiles, while the male line is closer to linear throughout. This indicates that tumour thickness does not conform to a normal distribution, with outliers affecting the general distribution. 

Age by Gender: The graph's pronounced linear correlation indicates that age is normally distributed across both genders.


## Recommendations and Future Direction

- Investigate biological or lifestyle factors that may elucidate the disparities in survival rates across genders, encompassing hormonal influences, genetic variations, healthcare accessibility, or behavioural tendencies.

- Evaluate the efficacy of diverse treatment modalities concerning tumour attributes and patient-specific variables, including surgery, immunotherapy, and targeted therapies.

- Analyse the heterogeneity of melanoma cancers, encompassing genetic differences and molecular subtypes, to identify possible targets for personalised therapies.

[Click here to view the R script](Melanoma_Report./script.R)
