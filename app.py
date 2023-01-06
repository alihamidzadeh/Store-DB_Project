from flask import Flask, request
from flask_mysql_connector import MySQL
import hashlib

app = Flask(__name__)

app.config['MYSQL_HOST'] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "root"
app.config["MYSQL_DATABASE"] = "StoreProject"

mysql = MySQL(app)
logedIn = False
@app.route('/login/<username>/<pwd>')
def login(username, pwd):
    global logedIn
    rsp = ""
    if not logedIn:
        cursor = mysql.connection.cursor()
        cursor.execute("select * from Staff where userName=\"{}\"".format(username))
        res = cursor.fetchall()
        if len(res) > 1 or len(res) == 0:
            rsp = "Two users with same username or wrong username!"
        else:
            user = res[0]
            password = user[14]
            pwdhash = hashlib.sha256(pwd.encode('utf-8')).hexdigest()
            if pwdhash == password:
                logedIn = True
                rsp = "Logged in successfully!"
            else:
                rsp = "Incorrect Password!"
        cursor.close()
    else:
        rsp = "You're logged in! please logout to login!"
    return rsp
@app.route('/logout')
def logout():
    global logedIn
    rsp = ""
    if not logedIn:
        rsp = "You're not logged in!"
    else:
        logedIn = False
        rsp = "logged out successfully!"
    return rsp
