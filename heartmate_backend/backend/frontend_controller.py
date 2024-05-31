import json
from prediction import predict
import heatmate_db_connector as conn
from flask import Flask, request

app = Flask(__name__)

#route url of the api
@app.route('/')
def about_heartmate():
    print("Hello HeartMate")
    return "Hello HeartMate"

@app.route('/login', methods=['POST'])
def login():
    login = request.data
    login = json.loads(login.decode('utf-8'))

    result = conn.login_val(login['userInfo'])
    return result

@app.route('/signup', methods=['POST'])
def signup():
    signup = request.data
    signup = json.loads(signup.decode('utf-8'))

    result = conn.signup_val(signup['userInfo'])
    return result

@app.route('/prediction', methods=['POST'])
def return_prediction():
    #dictionary to store the prediction result
    d = {}
    #list to arrange the risk factors
    riskFactors = []
    #Getting the user input data from the requests
    inputs = request.data
    #decoding the sent data
    inputs = json.loads(inputs.decode('utf-8'))
    #accessing the dictionary containing the user input data
    m = inputs['userInfo']
    #Arranging the user input data in the list
    riskFactors.append(int(m['age']))
    riskFactors.append(float(m['sysBP']))
    riskFactors.append(int(m['prevelantHyp']))
    riskFactors.append(float(m['diaBP']))
    riskFactors.append(float(m['glucose']))
    riskFactors.append(int(m['gender']))
    riskFactors.append(int(m['diabetes']))
    riskFactors.append(float(m['totChol']))
    riskFactors.append(float(m['bpMeds']))
    riskFactors.append(float(m['bmi']))

    #Getting the prediction result
    result = predict([riskFactors])
    #storing the test data inside the databse
    conn.add_test(m, result)

    #storing the prediction result in the dictionary
    d['result'] = result
    return d

@app.route('/viewtest', methods=['POST'])
def return_tests():
    userId = request.data
    userId = json.loads(userId.decode('utf-8'))

    result = conn.fetch_tests(userId['userId'])
    return result

@app.route('/dates', methods=['GET'])
def return_dates():
    userId = int(request.args['userId'])
    print(userId)
    result = conn.fetch_date(userId)
    print(result)
    return result

@app.route('/searchtest', methods=['POST'])
def return_searchedtest():
    testId = request.data
    testId = json.loads(testId.decode('utf-8'))

    result = conn.search_test(testId['testId'])
    return result

if __name__ == "__main__":
    app.run()
