# 🏠 Bayesian House Price Modeling with JAGS

This project analyzes the **King County House Sales dataset** (`kc_house_data.csv`) using **Bayesian regression models in R with JAGS**.  
The goal is to model housing prices, visualize data, and compare models using posterior predictive checks (PPC) and Deviance Information Criterion (DIC).

---

## 📂 Project Structure
- **Data Exploration**  
  - Histograms for all numeric variables  
  - Correlation analysis with price  

   ### Correlation Plots

![Correlation with Price](../plots/correlation_with_price.png)
![Pairwise Correlations Histogram](../plots/pairwise_correlations_hist.png)
- **Data Preparation**  
  - Log-transform of skewed variables (`price`, `sqft_living`, etc.)  
  - Scaling predictors for regression  

- **Modeling**  
  - **Model 1**: Simple regression (`sqft_living`, `grade`)  
  - **Model 2**: Extended regression (`sqft_living`, `grade`, `sqft_above`, `sqft_living15`, `bathrooms`)  
  - Bayesian estimation with JAGS  
  - Posterior summaries for parameters  
  - Posterior predictive checks (log scale & price scale)  

- **Model Comparison**  
  - Compare Bayesian models with frequentist OLS regression  
  - Use DIC for Bayesian model selection  

---
## 📊 Key Outputs

### Correlation Plots

![Correlation with Price](../plots/correlation_with_price.png)
![Pairwise Correlations Histogram](../plots/pairwise_correlations_hist.png)

### Posterior Predictive Checks

#### Model 1
![PPC Density Model 1](../plots/ppc_model1_density.png)
![PPC Histogram Model 1](../plots/ppc_model1_hist.png)

#### Model 2
![PPC Density Model 2](../plots/ppc_model2_density.png)
![PPC Histogram Model 2](../plots/ppc_model2_hist.png)


### Trace Plots

![Trace Model 1](../plots/trace_model1.png)
![Trace Model 2](../plots/trace_model2.png)




## 🚀 How to Run
```bash
git clone https://github.com/yourusername/house-price-bayes.git
cd house-price-bayes

