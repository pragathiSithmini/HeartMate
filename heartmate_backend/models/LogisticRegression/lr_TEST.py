import pickle

model = pickle.load(open('LogR.pickle', 'rb'))

# Loading the scaler
scaler = pickle.load(open('scaler.pickle', 'rb'))

age = float(input("Age : "))
cigsPerDay = float(input("cigsPerDay : "))
totChol = float(input("totChol : "))
sysBP = float(input("sysBP : "))
diaBP = float(input("diaBP : "))
glucose = float(input("glucose : "))
prevalentHyp = float(input("prevalentHyp : "))
diabetes = float(input("diabetes : "))

expected_result = str(input("Expected result : "))

parameters = [[age, cigsPerDay, totChol, sysBP, diaBP, glucose, prevalentHyp, diabetes]]
parameters = scaler.transform(parameters)

predict = model.predict(parameters)

if predict == 0:
    result = 'Negative'
else:
    result = 'Positive'

print("Expected result : " + expected_result + "\n" + "Actual result : " + result + "\n\n")