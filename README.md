# beatingthemarket

DATA

For the Artificial Neural Network and Support Vector Machine models, use PSEI.xlsx (open, high, low, and close prices) as input. For Sentiment Analysis, use pseiandsentiment.xlsx (sentiment scores and close prices). For Artificial Neural Network - Sentiment Analysis and Support Vector Machine - Sentiment Analysis, use sentimentandprices2.xlsx (sentiment scores, open, high, low, and close prices). 

From hereon, the sentiment scores (see allscores.xlsx) refer to the scores resulting from running Sentiment Analysis.R using five years' worth of daily news articles from the Inquirer.net website (data excluded due to size). These news articles are collected using Text Mining.R. After collection, these news articles are tokenized so the stop words (using the stop_words by R that combines snowball, SMART, and onyx) can be removed. Once the tokenized dataset is clean, the sentiment lexicon AFINN-111 is used to give a corresponding score for each word. These scores are aggregated so that there is only one score per day. This score is referred to as the sentiment score.

MODELS

The ANN and ANN-SA models use resilient backpropagation with weight backtracking. The default error function (sum of squared errors) and the default activation function (logistic function) are used. Since the model uses rprop, there is no need to set a learning rate. The threshold is set at 0.01. The ANN model has one input layer with four input neurons, two hidden layers with 50 neurons each, and one output layer with one output neuron. The ANN-SA model differs only by having five input neurons in the input layer, but the hidden and output layers are the same as in the ANN model. To avoid overfitting, the models are trained a maximum of ten times only. 

The SVM and SVM-SA models are of eps-regression type. The default values for C (1) and epsilon (0.1) are used. For the kernel function, the default Gaussian radial basis kernel method is used. 

The SA model uses the Random Forest algorithm to train using the sentiment scores and the close prices. 

PERFORMANCE MEASURES

After running the five models, the output must be the same as in ALL.xlsx. These results can be evaluated using the performance measures (R-squared, Mean Squared Error, and Directional Accuracy). 

TRADING STRATEGY

The development of the trading strategy does not involve machine learning techniques, but the algorithm works as follows:

1. The actual price at day i is compared to the predicted price at day i + 1.
2. If the actual price at day i was less than the predicted price at day i+1, the decision was to buy if the investor is not holding the stock yet. The actual price of the stock at day i was then deducted from the seed money that the investor is holding.
In case the investor is already holding the stock, the decision was to hold onto the stock until the decision makes a turning point (i.e., the decision became to sell), causing no change in the seed money.
3. If the actual price at day i was greater than the predicted price at day i+1, the decision was to sell if the investor is already holding the stock. The actual price of the stock at day i was then added to the seed money that the investor is holding.
In case the investor is not holding the stock, the decision was to do nothing, and the seed money remained the same.

This algorithm makes use of the following assumptions:

1. The actual daily closing price was used as the selling and buying price when orders are placed. Orders (buying and selling) could only be placed once per day.
2. The strategy ignored taxes, trading commissions, and other fees related to trading to simplify computations for the returns.
3. Buying and selling a stock referred to buying and selling stocks from any of the companies included in the PSEi. The PSEi was considered as the aggregate price of the stocks listed in the index to simplify calculations.
4. The trading began with the investor having PHP 10,000 as initial “seed money” which can be used to buy an indexed stock when the prediction shows that the stock will increase in value. Since the actual prices of the PSEi for the trading strategy ranges from 7,000 to 8,000 and the seed money is only 10,000, the strategy was limited to buying and selling only one stock at a time.
5. The trading strategy gives only four decisions: "Buy", "Sell", "Hold", and "Do Nothing". 

To evaluate the trading strategy, the annualized return (computed as the mean of the logarithmic returns multiplied by the number of trading days) is used.

RESULTS

Based on the results, ANN is better than SVM. Combining ANN with SA improves the stand-alone ANN (as seen in the ANN-SA), but combining SVM with SA does not have an improving effect on the stand-alone SVM (as seen in the SVM-SA). For the trading strategy, the ANN model achieves the highest return out of the five, which means that the magnitude of the returns depend heavily on the accuracy of the model's predictions.
