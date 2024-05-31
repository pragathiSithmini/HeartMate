import pickle


def predict(inputs):
    #loading the model
    model = pickle.load(open('pickles/randomForest.pickle', 'rb'))

    # Loading the scaler
    scaler = pickle.load(open('pickles/scaler.pickle', 'rb'))

    #scaling the inputs
    parameters = scaler.transform(inputs)

    #making the prediction
    predict = model.predict(parameters)

    #defining the prediction as negative or positive
    if predict == 0:
        return "Negative"
    else:
        return "Positive"
