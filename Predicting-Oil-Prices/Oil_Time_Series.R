# Author: 
#   RIHAD VATIAWA
# 
# Time Series is a sequence of well-defined data points measured at consistent time 
# intervals over a period of time. ... Time series analysis is the use of statistical 
# methods to analyze time series data and extract meaningful statistics and characteristics about the data.
# 
# The goal of this project was to use various (ts) time series methods in order to
# make predictions on a dataset of our choice. The modeling techniques used are:
# 
# ARIMA models 
# Exponential Smoothing models
# Facebooks Prophet model
# 
# The data sourced for our ts project came from the link below 
# This data consists of monthly WTI (West Texas Intermediate) oil prices from Cushing,
# Oklahoma. The data extends from Jan 1986 upto 21 Dec 2019. 
#   https://fred.stlouisfed.org/series/MCOILWTICO
#
# Background
# Time series datasets are the most widely generated and used kind of data deployed in 
# business. It is used both in understanding the past and predicting the future.
# 
# Understanding and decomposing ts data
## So what is ts data?
# a ts is a sequence of observations recorded in discrete time points. It can be recorded in
# 
# hourly (e.g. air temp), 
# daily (e.g. DJI Averages),
# monthly (e.g. sales),
# yearly (e.g. GPD)
# 
# time intervals. TS plotting is one of the most basic plotting exercises implemented during the 
# EDA phase of analytics and data science.
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- #

# install packages
library(fpp2)
library(astsa)
library(tseries)
library(forecast) # statistical
library(dplyr)
library(prophet)


# load in data 
oil <- read.csv('MCOILWTICO.csv')

# preview the data
head(oil) 

# glimpse(oil)

# transform / convert  dataset into a ts object
oil_ts <- ts(oil$MCOILWTICO, start = c(1986, 1), frequency = 12)

# visualize / plot our ts object
plot(oil_ts) 

# training data - all data except last six months: YR, MONTH
train <- window(oil_ts, c(1986, 1), c(2017, 8)) 
# plot(train)

# testing data - just the last six months: YR, MONTH
test <- window(oil_ts, c(2017, 9), c(2018, 2))
# plot(test)

# visualize / plot train and test data
plot(train) 
lines(test, col = 'red') 

#############
# ARIMA Model
#############

# ARIMA has 3 components: a) autoregression - component that models the relationship
# btw the series and it's lagged observation, b) moving average - component that model that models
# the forecast as a function of lagged forecast errors, c) integrated - component that makes the
# series stationary.

# the model takes in the following params values:

# p = defines the number of lags
# d = specifies the number of differences used
# q = defines the size of moving sverage window


## Step 1: Visualize the ts object
# for obvious trend and increasing variance
plot(oil_ts) 

## Step 2: Check for stationarity
# using a diff and a log to stationarize the data
plot(diff(log(train))) 

adf.test(train)
# passes the Dickey Fuller test
adf.test(diff(log(train))) 

# acf tails off - pacf kinda tails sorta
acf2(train) 

## ACF and PACF
# Autocorrelation refers to how correlated a ts (future value) is with its past values 
# whereas the ACF is the plot used to see the correlation (relationship) between 
# the points, upto and including the lag unit. 
# In ACF, the correlation coefficient is in the y-axis whereas the number 
# of lags is shown in the x-axis.

# suggests: p=2, d=1, q=2, P=0, D=0, Q=2, S=12
auto.arima(train) 

# first model --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
fit <- sarima(log(train), p=2, d=1, q=2, P=0, D=0, Q=2, S=12)

# preview AIC and BIC of model
print(cbind(fit$AIC, fit$BIC)) 
fit$ttable 

sarima_oil <- as.ts(sarima.for(train, n.ahead = 6, p=2, d=1, q=2, P=0, D=0, Q=2, S=12))

# compare predicted and actual
lines(test, col = 'blue') 

# preview accuracy of model
accuracy(sarima_oil$pred, test) 


# second model --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
fit2 <- sarima(log(train), p=2, d=1, q=0, P=0, D=0, Q=0, S=12)

# preview AIC and BIC of model
print(cbind(fit2$AIC, fit2$BIC)) 
fit2$ttable 

sarima_oil2 <- as.ts(sarima.for(train, n.ahead = 6, p=2, d=1, q=0, P=0, D=0, Q=1, S=12))

# compare predicted and actual
lines(test, col = 'blue') 

# preview accuracy of model
accuracy(sarima_oil2$pred, test) 

# third model --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
fit3 <- sarima(log(train), p=2, d=1, q=2, P=1, D=0, Q=2, S=12)

# preview AIC and BIC of model
print(cbind(fit3$AIC, fit3$BIC)) 
fit3$ttable 

sarima_oil3 <- as.ts(sarima.for(train, n.ahead = 6, p=2, d=1, q=2, P=1, D=0, Q=2, S=12))

# compare predicted and actual
lines(test, col = 'blue') 

# preview accuracy of model
accuracy(sarima_oil3$pred, test) 

# forth model --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
fit4 <- sarima(log(train), p=2, d=1, q=1, P=1, D=0, Q=1, S=12)

# preview AIC and BIC of model
print(cbind(fit4$AIC, fit4$BIC)) 
fit4$ttable 

sarima_oil4 <- as.ts(sarima.for(train, n.ahead = 6, p=2, d=1, q=1, P=1, D=0, Q=1, S=12))

# compare predicted and actual
lines(test, col = 'blue') 

# preview accuracy of model
accuracy(sarima_oil4$pred, test) 

# ARIMA Summary:
# first model was best - slightly less accurate than third model but less complex
# AR only model was not as good as first model even though suggested by ACF and PACF plots


#############################
# Exponetial Smoothing Model
#############################

# now trying simple exponetial smoothing due to trend in data

# holt model
fit_holt <- holt(train, h = 12)
summary(fit_holt)

# checking for autocorrelation in residuals
checkresiduals(fit_holt) 

# plotting model fit
autoplot(fit_holt) + autolayer(fitted(fit_holt)) 

# checking model accuracy
accuracy(fit_holt, test) 

# forecast test values
for_fit <- forecast(fit_holt, h = 6) 

# plot the predicted data
plot(for_fit) 
lines(test, col = 'red')

# holt model damped
fit_holt_d <- holt(train, h = 12, damped = TRUE)
summary(fit_holt_d)
checkresiduals(fit_holt_d)
autoplot(fit_holt_d) + autolayer(fitted(fit_holt_d))
accuracy(fit_holt_d, test)

for_fit2 <- forecast(fit_holt_d, h = 6)
plot(for_fit2)
lines(test, col = 'red')

# holt winters model - dont expect this model to work super well - no clear seasonality in the data
fit_hw <- hw(train, seasonal = "multiplicative")
summary(fit_hw)
checkresiduals(fit_hw)
autoplot(fit_hw) + autolayer(fitted(fit_hw))
accuracy(fit_hw, test)

for_fit3 <- forecast(fit_hw, h = 6)
plot(for_fit3)
lines(test, col = 'red')

# Exponential Smoothing Summary:
# holt model seems to predict the best
# makes sense as there is a trend but no seasonality

################
# Phophet Model
################

head(oil) 

# renaming columns for prophet modeling
colnames(oil)[1] <- 'ds' 
colnames(oil)[2] <- 'y'

# re-subsetting data - prophet requires dataframe instead of ts
oil_train = oil[1:380,] 
oil_test = oil[381:386,]

prophet_fit <- prophet(oil_train) 

# make df for forecasted predictions
future <- make_future_dataframe(prophet_fit, periods = 6, freq = 'month') 
forecast <- predict(prophet_fit, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])
plot(prophet_fit, forecast)
prophet_plot_components(prophet_fit, forecast)

# checking model accuracy
accuracy(forecast[c('yhat')][380:386,], test) 

# Prophet model summary:
# fits better than exponential smoothing models but not as well as final ARIMA model


