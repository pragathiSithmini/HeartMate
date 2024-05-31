import heatmate_db_connector as conn

def test_login_val():
    user_info = {}
    user_info["email"] = "testone@heatmate.com"
    user_info["password"] = "12345678"
    result = conn.login_val(user_info)
    assert result["result"] == "success"
    assert result["name"] == "Test"
    assert result["id"] == 1004
    assert result["age"] == 21
    assert result["gender"] == 0

def test_signup_val():
    userinfo = {}
    userinfo["firstName"] = "Test"
    userinfo["lastName"] = "One"
    userinfo["email"] = "testone@heatmate.com"
    userinfo["password"] = "12345678"
    userinfo["dob"] = "2000-12-31"
    userinfo["gender"] = "0"
    result = conn.signup_val(userinfo)
    assert result["result"] == "unsuccessful"

def test_add_test():
    testData = {}
    testData["userId"] = 1014
    testData["date"] = "2022/01/31"
    testData["age"] = 27
    testData["sysBP"] = 170
    testData["prevelantHyp"] = 1
    testData["diaBP"] = 60
    testData["glucose"] = 200
    testData["gender"] = 1
    testData["diabetes"] = 1
    testData["totChol"] = 370
    testData["bpMeds"] = 0
    testData["bmi"] = 33.8
    testResult = "Negative"
    result = conn.add_test(testData,testResult)
    assert result["result"] == "success"

def test_fetch_tests():
    expected = {}
    tests = []
    tests.append({'name': 'TEST 1',
                  'date': '2022-01-05',
                  'age': '21',
                  'sysBP': '190',
                  'prevelantHyp': 'Yes',
                  'diaBP': '90',
                  'glucose': '150',
                  'gender': 'Female',
                  'diabetes': 'Yes',
                  'totChol':'200',
                  'bpMeds': 'Yes',
                  'bmi': '22.8',
                  'result': 'Positive'})

    tests.append({'name': 'TEST 2',
                  'date': '2022-01-30',
                  'age': '21',
                  'sysBP': '180',
                  'prevelantHyp': 'Yes',
                  'diaBP': '70',
                  'glucose': '100',
                  'gender': 'Female',
                  'diabetes': 'Yes',
                  'totChol': '150',
                  'bpMeds': 'Yes',
                  'bmi': '22.5',
                  'result': 'Negative'})

    tests.append({'name': 'TEST 3',
                  'date': '2022-02-15',
                  'age': '21',
                  'sysBP': '170',
                  'prevelantHyp': 'No',
                  'diaBP': '80',
                  'glucose': '100',
                  'gender': 'Female',
                  'diabetes': 'No',
                  'totChol': '180',
                  'bpMeds': 'No',
                  'bmi': '21',
                  'result': 'Negative'})

    expected["result"] = tests
    assert conn.fetch_tests(1004) == expected

def test_fetch_date():
    expected = {}
    dates = []
    dates.append({'date': '2022-01-05',
                  'testId': 10004})
    dates.append({'date': '2022-01-30',
                  'testId': 10014})
    dates.append({'date': '2022-02-15',
                  'testId': 10024})

    expected["result"] = dates
    assert conn.fetch_date(1004) == expected

def test_search_test():
    expected = {}
    test = {'date': '2022-01-05',
            'age': '21',
            'sysBP': '190',
            'prevelantHyp': 'Yes',
            'diaBP': '90',
            'glucose': '150',
            'gender': 'Female',
            'diabetes': 'Yes',
            'totChol':'200',
            'bpMeds': 'Yes',
            'bmi': '22.8',
            'result': 'Positive'}

    expected["result"] = test
    assert conn.search_test(10004) == expected