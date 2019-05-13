# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

#### Split the data into training (80%) and test (20%) sets

Partition <- function(x, p=.8) {
  sample <- sample.int(n = nrow(x), size = floor(p*nrow(x)), replace = F)
  train <- x[sample, ]
  test  <- x[-sample, ]
  return(list(train=train,test=test))
}
x <- Partition(iris)

#### Create your model and use your model to predict group membership

DFA_pred <- function(model, data) {
  LDA_object <- MASS::lda(model, data)
  Predict.lda.values <- predict(LDA_object, data)
  return(Predict.lda.values)
}

y <- DFA_pred(Species~., x$train)
p <- DFA_pred(Species~., x$test)

#### Plotting the result in ggplot

DFA_plot <- function(data) {
  v <- as.data.frame(data)
  g<- ggplot2::ggplot(v, aes(v$x.LD1, v$x.LD2)) +
    geom_point(aes(color = v$class))
  g <- g + ggplot2::ggtitle("LDA Predictions")
  g <- g + ggplot2::xlab("LD1")
  g <- g + ggplot2::ylab("LD2")
}

h <- DFA_plot(y)
h
t <-DFA_plot(p)
t

#### Tests for Accuracy

Accuracy <- function(train_pred, test_pred, partitioned_list) {
  test <- mean(test_pred$class==x$test$Species)
  train <- mean(train_pred$class==x$train$Species)
  return(list(train=train,test=test))
}
Accuracy(y, p, x)



