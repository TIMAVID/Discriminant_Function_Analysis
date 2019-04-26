library(MASS) # required for the lda() function

learning_dat <- read.csv("YourLearningData.csv") # read in the data you will use to teach the analysis what each category looks like - minimally, you need a column for category (in your case, individual) plus one column for each of your variables
experimental_dat <- read.csv("YourExperimentalData.csv") # read in the data for which you will be predicting categories - this should be formatted exactly like your learing data

LDA_object <- lda(Category ~ Variable_1 + Variable_2 + Variable_3 + Variable_etc, data = learning_dat) # creates an object that is the results of the learning phase of the LDA - this is what you will use to predict what category each subsequent set of variables you feed it most likely belong to

Predict_results <- predict(LDA_object, newdata = experimental_dat) # use the LDA results object to predict the category for your experimental data - NOTE: if you have multiple rows in your experimental data, you'll need to use a for loop to compare each row to your LDA object - try this on your own first and if you can't make it work, I'll show you what I did