from flask import Flask, request, jsonify
from flask_mysql_connector import MySQL
import hashlib
import string
import random

app = Flask("StoreDataBaseApi")

app.config['MYSQL_HOST'] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "root"  # 1414
app.config["MYSQL_DATABASE"] = "storeproject"

mysql = MySQL(app)
def get_user(token):
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute("select * from login where token=\"{}\"".format(token))
    user = cursor.fetchall()
    if len(user) == 1:
        user = user[0]
        if user["isStaff"] == 1:
            cursor.execute("select * from staff where staffID=\"{}\"".format(user["userID"]))
        else:
            cursor.execute("select * from customer where customerID=\"{}\"".format(user["userID"]))
        res = cursor.fetchall()
        if len(res) == 1:
            return res[0]
        return None
    else:
        return None
def get_user_is_admin(token):
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute("select * from login where token=\"{}\"".format(token))
    user = cursor.fetchall()
    if len(user) == 1:
        user = user[0]
        if user["isStaff"] == 1:
            cursor.execute("select * from staff where staffID=\"{}\" and managerID is null".format(user["userID"]))
            res = cursor.fetchall()
            if len(res) == 1:
                return res[0]
    return None
def get_random_string(length):
    letters = string.ascii_lowercase
    result_str = ''.join(random.choice(letters) for i in range(length))
    return result_str
@app.route('/register/<userType>')
def register(userType):
    table = ""
    if userType.lower() == "customer":
        table = "customer"
    elif userType.lower() == "staff":
        table = "staff"
    else:
        return "Invalid type!"
    data = list(request.form.values())
    keys = list(request.form.keys())
    query = "insert into {}(".format(table)
    for key in keys:
        query += key
        if keys.index(key) != len(keys) - 1:
            query += ","
    query += ") values ("
    for dt in data:
        val = None
        if keys[data.index(dt)] == "password":
            val = hashlib.sha256(dt.encode('utf-8')).hexdigest()
        else:
            val = dt
        query += "\"{}\"".format(val)
        if data.index(dt) != len(data) -1:
            query += ','
    query += ")"
    mysql.connection.cursor().execute(query)
    mysql.connection.commit()
    return "Registerd!" 
@app.route('/login/<username>/<pwd>')  # pwd == 123example
def login(username, pwd):
    rsp = ""
    isStaff = 1 
    user = None
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute("select * from staff where userName=\"{}\"".format(username))
    res = cursor.fetchall()
    if len(res) > 1:
        rsp = "Two users with same username"
    elif len(res) == 0:
        isStaff = 0 
        cursor.execute("select * from customer where userName =\"{}\"".format(username))
        res = cursor.fetchall()
    if len(res) == 0:
        rsp = "No user found!"
    elif len(res) == 1:
        user = res[0]
        password = user['password']
        pwdhash = hashlib.sha256(pwd.encode('utf-8')).hexdigest()
        if pwdhash == password:
            ID = None
            if isStaff == 1:
                ID = user["staffID"] 
            else:
                ID = user["customerID"]
            cursor.execute("select * from login where userID=\"{}\" and isStaff=\"{}\"".format(ID,isStaff));
            isLogedIn = len(cursor.fetchall()) == 1
            if not isLogedIn:
                rsp = get_random_string(256)
                print("insert into login values (\"{}\", {}, {})".format(rsp,ID,isStaff))
                cursor.execute("insert into login values (\"{}\", {}, {})".format(rsp,ID,isStaff))
                mysql.connection.commit()
            else:
                rsp = "You're Loged in!"
        else:
            rsp = "Incorrect Password!"

        cursor.close()
    else:
        rsp = "You're logged in! please logout to login!"
    return rsp 

@app.route('/logout')
def logout():
    rsp = ""
    token = request.form["token"];
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute("select * from login where token=\"{}\"".format(token))
    res = cursor.fetchall()
    if len(res) != 1:
        rsp = "Not Loged In!"
    else:
        cursor.execute("delete from login where token=\"{}\"".format(token))
        mysql.connection.commit()
        rsp = "Loged out!"
    return rsp

@app.route('/get-all-items')
def get_all_items():
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute("select * from item")
    res = cursor.fetchall()
    cursor.close()
    return res


@app.route('/get-unique-categories')
def get_unique_categories():
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute("select distinct category from item")
    res = cursor.fetchall()
    cursor.close()

    return res


@app.route('/get-all-orders')
def get_all_orders():
    rsp = "Not logged in or you dont have permession!"
    if get_user_is_admin(request.form["token"]) != None:
        cursor = mysql.connection.cursor(dictionary=True)
        cursor.execute("select * from `order`")
        rsp = cursor.fetchall()
        cursor.close()
    return rsp


@app.route('/get-suppliers/<item_id>')
def get_suppliers(item_id):
    res = "Not logged in!"
    if get_user(request.form["token"]) != None:
        cursor = mysql.connection.cursor(dictionary=True)
        cursor.execute("""
        select * from item, supplier, supplier_supplies_item 
        where item.itemID = %s 
        and supplier_supplies_item.Item_itemID = item.itemID 
        and supplier.supplierID = supplier_supplies_item.Supplier_supplierID""", (item_id,))
        res = cursor.fetchall()
        cursor.close()

    return res


@app.route('/get-best-supplier/<item_id>')
def get_best_supplier(item_id):
    rsp = "Not logged in or you dont have permession!"
    if get_user_is_admin(request.form["token"]) != None:
        cursor = mysql.connection.cursor(dictionary=True)
        cursor.execute("""
        select *
        from item, supplier, supplier_supplies_item
        where item.itemID = %s
        and supplier_supplies_item.Item_itemID = item.itemID
        and supplier.supplierID = supplier_supplies_item.Supplier_supplierID
        order by item.currentPrice desc
        limit 1""", (item_id,))

        rsp = cursor.fetchall()
        cursor.close()
    return rsp


@app.route('/get-comments/<item_id>')
def get_comments(item_id):
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute("""
    SELECT comments.commentID, comments.title, comments.date, comments.text, comments.itemID, comments.customerID
    FROM item 
    INNER JOIN comments ON comments.itemID = item.itemID
    WHERE comments.itemID = %s """, (item_id,))

    res = cursor.fetchall()
    cursor.close()

    return res


@app.route('/get-done-average-price')
def get_done_average_price():
    rsp = "Not logged in or you dont have permession!"
    if get_user_is_admin(request.form["token"]) != None:
        cursor = mysql.connection.cursor(dictionary=True)
        cursor.execute('select avg(totalPrice) from `order` o where o.`status` = "Done"')
        rsp = cursor.fetchall()
        cursor.close()
    return rsp


@app.route('/get-customers-by-city/<city>')
def get_customers_by_city(city):
    rsp = "Not logged in or you dont have permession!"
    if get_user_is_admin(request.form["token"]) != None:
        cursor = mysql.connection.cursor(dictionary=True)
        cursor.execute("""
        select * from customer c
        where exists ( select * from Addresses a where a.customerID = c.customerID and a.city = %s)""",
                       (city,))

        rsp = cursor.fetchall()
        cursor.close()
    return rsp


@app.route('/get-suppliers-by-city/<city>')
def get_suppliers_by_city(city):
    rsp = "Not logged in or you dont have permession!"
    if get_user_is_admin(request.form["token"]) != None:
        cursor = mysql.connection.cursor(dictionary=True)
        cursor.execute('''
        select *
        from Supplier s
        where s.address like %s ''', ('%' + city + '%',))
        rsp = cursor.fetchall()
        cursor.close()
    return rsp


@app.route('/productList')
def productList():
    query = 'select * from item'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    return jsonify({'Product List': result})


@app.route('/userList')
def userList():
    rsp = "Not logged in or you dont have permession!"
    if get_user_is_admin(request.form["token"]) != None:
        query = 'select * from customer'
        cursor = mysql.connection.cursor(dictionary=True)
        cursor.execute(query)
        result = cursor.fetchall()
        rsp = jsonify({'User List': result})
        cursor.close()
    return rsp

@app.route('/categoryList')
def categoryList():
    query = 'select distinct category from item'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Category List': result})


@app.route('/orderList')
def orderList():
    query = 'select * from `order`'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Order List': result})

@app.route('/userOrderList')
def userOrderList():
    rsp = "Not logged in!"
    if get_user(request.form["token"]) != None:
        user = get_user(request.form["token"])
        cursor = mysql.connection.cursor(dictionary=True)
        query = ""
        if "customerID" in list(user.keys()):
            query = "select * from `order` where customerID = {}".format(user["customerID"])
        else:
            query = "select * from `order`"
        cursor.execute(query)
        rsp = cursor.fetchall()
        cursor.close()
    return rsp
@app.route('/getTenBetterUser')
def tenBetterUserList():
    query = 'select customerID, fName, lName, phoneNumber, ssn, userName, score '
    query += 'from customer '
    query += 'order by score desc '
    query += 'limit 10;'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'User List': result})


@app.route('/bestSellerItemsList')
def bestSellerItemsList():
    query = 'select * '
    query += 'from item'
    query += 'order by score desc '
    query += 'limit 5'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Item List': result})


@app.route('/specialOfferList')
def specialOfferList():
    query = 'select itemID, name, currentPrice, category, offer '
    query += 'from item'
    query += 'where offer >= 15;'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Item List': result})


@app.route('/supplierList/<itemId>')
def supplierList(itemId):
    query = 'select * '
    query += 'from item, supplier, supplier_supplies_item '
    query += 'where supplier_supplies_item.Item_itemID = item.itemID '
    query += 'and supplier.supplierID = supplier_supplies_item.Supplier_supplierID '
    query += 'and item.itemID = {}'.format(itemId)
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({"Supplier List": result})
 

@app.route('/cheapestSeller/<itemId>')
def cheapestSellerList(itemId):
    query = 'select * '
    query += 'from item, supplier, supplier_supplies_item '
    query += 'where supplier_supplies_item.Item_itemID = item.itemID '
    query += 'and supplier.supplierID = supplier_supplies_item.Supplier_supplierID '
    query += 'and item.itemID = \"{}\"'.format(itemId)
    query += 'order by item.currentPrice desc '
    query += 'limit 1'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'seller list': result})


if __name__ == '__main__':
    app.run(debug=True)
