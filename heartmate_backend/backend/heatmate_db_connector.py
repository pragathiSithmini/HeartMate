import mysql.connector
from datetime import date

HOST = "us-cdbr-east-05.cleardb.net"
PORT = "3306"
USER = "b5435f31808b2a"
PASSWORD = "e8968ff1"
DATABASE = "heroku_a073b44a07ad5e4"

def login_val(userinfo):
    try:
        mydb = mysql.connector.connect(
            host=HOST,
            port=PORT,
            user=USER,
            password=PASSWORD,
            database=DATABASE
        )
        cursor = mydb.cursor()

        print("connection started")

        query = "SELECT password, fName, id, dob, gender FROM usertable WHERE email ='%s'" % userinfo['email']

        cursor.execute(query)

        user_data = cursor.fetchall()
        print(user_data)

        result = {}

        if len(user_data) != 0:
            password = user_data[0][0]
            if password == userinfo['password']:
                result["result"] = "success"
                result["name"] = user_data[0][1]
                result["id"] = user_data[0][2]
                dob = user_data[0][3]
                dob = dob.split("-")
                today = date.today()
                result["age"] = today.year - int(dob[0]) - ((today.month, today.day) < (int(dob[1]), int(dob[2])))
                result["gender"] = user_data[0][4]

            else:
                result["result"] = "unsuccessful"
                result["name"] = ""
                result["id"] = ""
                result["age"] = ""
                result["gender"] = ""
        else:
            result["result"] = "unsuccessful"
            result["name"] = ""
            result["id"] = ""
            result["age"] = ""
            result["gender"] = ""

        return result

    except mysql.connector.Error as error:

        print(f"ERROR- {error}")

        return 0

    finally:

        if mydb.is_connected():
            cursor.close()
            mydb.close()
            print("MySQL connection is closed")

def signup_val(userinfo):
    try:
        mydb = mysql.connector.connect(            host=HOST,
            port=PORT,
            user=USER,
            password=PASSWORD,
            database=DATABASE
        )
        cursor = mydb.cursor()

        print("connection started")

        query = "INSERT INTO usertable (fName, sName, email, password, dob, gender) VALUES (%s, %s, %s, %s, %s, %s)"

        tuple = (userinfo["firstName"], userinfo["lastName"], userinfo["email"], userinfo["password"], userinfo["dob"], userinfo["gender"])

        cursor.execute(query, tuple)
        mydb.commit()

        result = {"result": "success"}

        return result

    except mysql.connector.errors.IntegrityError as i:
        result = {"result": "unsuccessful"}
        return result


    except mysql.connector.Error as error:

        print(f"ERROR- {error}")

        return 0

    finally:

        if mydb.is_connected():
            cursor.close()
            mydb.close()
            print("MySQL connection is closed")
            
def add_test(testData, testResult):
    try:
        #connecting to the databse
        mydb = mysql.connector.connect(
            host=HOST,
            port=PORT,
            user=USER,
            password=PASSWORD,
            database=DATABASE
        )
        #getting the cursor
        cursor = mydb.cursor()

        print("connection started")

        #defining the query
        query = "INSERT INTO tests (id, testDate, age, sysBP, prevelantHyp, diaBP, glucose, gender, diabetes, totChol, bpMeds, bmi, testResult ) VALUES (%s, %s, %s, %s,%s, %s, %s, %s,%s, %s, %s, %s,%s)"

        #data to be stored inside the databse
        tuple = (int(testData["userId"]), str(testData["date"]), str(testData["age"]), str(testData["sysBP"]), str(testData["prevelantHyp"]), str(testData["diaBP"]), str(testData["glucose"]),
                 str(testData["gender"]), str(testData["diabetes"]), str(testData["totChol"]), str(testData["bpMeds"]), str(testData["bmi"]), testResult)

        #excecuting the query
        cursor.execute(query, tuple)
        #comming changes to databse
        mydb.commit()

        #result of the datsbase function
        result = {"result": "success"}

        return result

    #if the test id alredy exists
    except mysql.connector.errors.IntegrityError as i:
        result = {"result": "unsuccessful"}
        return result

    #heandeling errors
    except mysql.connector.Error as error:

        print(f"ERROR- {error}")

        return 0

    finally:

        #closing the databse connection
        if mydb.is_connected():
            cursor.close()
            mydb.close()
            print("MySQL connection is closed")

def fetch_tests(userId):
    try:
        mydb = mysql.connector.connect(
            host=HOST,
            port=PORT,
            user=USER,
            password=PASSWORD,
            database=DATABASE
        )

        cursor = mydb.cursor()

        print("connection started")

        query = "SELECT * FROM tests WHERE id ='%s'" % userId

        cursor.execute(query)

        user_data = cursor.fetchall()

        tests = []
        count = 1

        for i in user_data:
            test = {}
            test["name"] = "TEST " + str(count)

            test["date"] = i[2]

            test["age"] = i[3]

            test["sysBP"] = i[4]

            if i[5] == "1":
                test["prevelantHyp"] = "Yes"
            else:
                test["prevelantHyp"] = "No"

            test["diaBP"] = i[6]

            test["glucose"] = i[7]

            if i[8] == "1":
                test["gender"] = "Male"
            else:
                test["gender"] = "Female"

            if i[9] == "1":
                test["diabetes"] = "Yes"
            else:
                test["diabetes"] = "No"

            test["totChol"] = i[10]

            if i[11] == "1":
                test["bpMeds"] = "Yes"
            else:
                test["bpMeds"] = "No"

            test["bmi"] = i[12]

            test["result"] = i[13]

            tests.append(test)
            count += 1

        return {"result" : tests}


    except mysql.connector.Error as error:

        print(f"ERROR- {error}")

        return 0

    finally:

        if mydb.is_connected():
            cursor.close()
            mydb.close()
            print("MySQL connection is closed")

def fetch_date(userId):
    try:
        mydb = mysql.connector.connect(
            host=HOST,
            port=PORT,
            user=USER,
            password=PASSWORD,
            database=DATABASE
        )
        cursor = mydb.cursor()

        print("connection started")

        query = "SELECT testId,testDate FROM tests WHERE id ='%s'" % userId

        cursor.execute(query)

        user_data = cursor.fetchall()
        print(user_data)

        dates = []

        for i in user_data:
            test = {}
            test['date'] = i[1]
            test['testId'] = i[0]
            dates.append(test)

        return {"result" : dates}

    except mysql.connector.Error as error:

        print(f"ERROR- {error}")

        return 0

    finally:

        if mydb.is_connected():
            cursor.close()
            mydb.close()
            print("MySQL connection is closed")

def search_test(testId):
    try:
        mydb = mysql.connector.connect(
            host=HOST,
            port=PORT,
            user=USER,
            password=PASSWORD,
            database=DATABASE
        )

        cursor = mydb.cursor()

        print("connection started")

        query = "SELECT * FROM tests WHERE testId ='%s'" % int(testId)

        cursor.execute(query)

        i = cursor.fetchall()

        test = {}

        test["date"] = i[0][2]

        test["age"] = i[0][3]

        test["sysBP"] = i[0][4]

        if i[0][5] == "1":
            test["prevelantHyp"] = "Yes"
        else:
            test["prevelantHyp"] = "No"

        test["diaBP"] = i[0][6]

        test["glucose"] = i[0][7]

        if i[0][8] == "1":
            test["gender"] = "Male"
        else:
            test["gender"] = "Female"

        if i[0][9] == "1":
            test["diabetes"] = "Yes"
        else:
            test["diabetes"] = "No"

        test["totChol"] = i[0][10]

        if i[0][11] == "1":
            test["bpMeds"] = "Yes"
        else:
            test["bpMeds"] = "No"

        test["bmi"] = i[0][12]

        test["result"] = i[0][13]

        return {"result" : test}


    except mysql.connector.Error as error:

        print(f"ERROR- {error}")

        return 0

    finally:

        if mydb.is_connected():
            cursor.close()
            mydb.close()
            print("MySQL connection is closed")
