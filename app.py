from flask import Flask, request, jsonify
from flask_mysql_connector import MySQL
import hashlib

app = Flask("StoreDataBaseApi")

app.config['MYSQL_HOST'] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "1414"  # 1414
app.config["MYSQL_DATABASE"] = "storeproject"

mysql = MySQL(app)
user = None


@app.route('/login/<username>/<pwd>')  # pwd == 123example
def login(username, pwd):
    global user
    rsp = ""
    if not user:
        cursor = mysql.connection.cursor(dictionary=True)
        cursor.execute("select * from Staff where userName=\"{}\"".format(username))
        res = cursor.fetchall()
        if len(res) > 1 or len(res) == 0:
            rsp = "Two users with same username or wrong username!"
        else:
            user = res[0]
            password = user['password']
            pwdhash = hashlib.sha256(pwd.encode('utf-8')).hexdigest()
            if pwdhash == password:
                # rsp = "Logged in successfully!"
                cursor.execute("select * from Staff")
                rsp = cursor.fetchall()

            else:
                rsp = "Incorrect Password!"
        cursor.close()
    else:
        rsp = "You're logged in! please logout to login!"
    return rsp


@app.route('/logout')
def logout():
    global user
    rsp = ""
    if not user:
        rsp = "You're not logged in!"
    else:
        user = None
        rsp = "logged out successfully!"
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
    global user

    if not user:
        return "You're not logged in!"

    if user['role'] != 'Manager':
        return 'You dont have permission'

    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute("select * from StoreProject.`Order`")
    rsp = cursor.fetchall()
    cursor.close()

    return rsp


@app.route('/get-suppliers/<item_id>')
def get_suppliers(item_id):
    global user

    if not user:
        return "You're not logged in!"

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
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute("""
    select *
    from item, supplier, supplier_supplies_item
    where item.itemID = %s
    and supplier_supplies_item.Item_itemID = item.itemID
    and supplier.supplierID = supplier_supplies_item.Supplier_supplierID
    order by item.currentPrice desc
    limit 1""", (item_id,))

    res = cursor.fetchall()
    cursor.close()

    return res


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
    global user

    if not user:
        return "You're not logged in!"

    if user['role'] != 'Manager':
        return 'You dont have permission'

    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute('select avg(totalPrice) from StoreProject.`Order` o where o.`status` = "Done"')
    rsp = cursor.fetchall()
    cursor.close()

    return rsp


@app.route('/get-customers-by-city/<city>')
def get_customers_by_city(city):
    global user

    if not user:
        return "You're not logged in!"

    if user['role'] != 'Manager':
        return 'You dont have permission'

    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute("""
    select * from StoreProject.Customer c
    where exists ( select * from StoreProject.Addresses a where a.customerID = c.customerID and a.city = %s)""",
                   (city,))

    rsp = cursor.fetchall()
    cursor.close()

    return rsp


@app.route('/get-suppliers-by-city/<city>')
def get_suppliers_by_city(city):
    global user

    if not user:
        return "You're not logged in!"

    if user['role'] != 'Manager':
        return 'You dont have permission'

    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute('''
    select *
    from StoreProject.Supplier s
    where s.address like %s ''', ('%' + city + '%',))

    rsp = cursor.fetchall()
    cursor.close()

    return rsp


@app.route('/productList')
def productList():
    query = 'select * from item;'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Product List': result})


@app.route('/userList')
def userList():
    query = 'select * from customer;'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'User List': result})


@app.route('/categoryList')
def categoryList():
    query = 'select distinct category from item;'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Category List': result})


@app.route('/orderList')
def orderList():
    query = 'select * from StoreProject.`Order`;'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Order List': result})


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
    query += 'from item '
    query += 'order by score desc '
    query += 'limit 5;'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Item List': result})


@app.route('/specialOfferList')
def specialOfferList():
    query = 'select itemID, name, currentPrice, category, offer '
    query += 'from item '
    query += 'where offer >= 15;'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Item List': result})


@app.route('/supplierList/<itemId>')
def supplierList(itemId):
    query = 'select * '
    query += 'from item, supplier, supplier_supplies_item '
    query += f'where item.itemID = {itemId} -- given value '  # TODO change itemId to itemName
    query += 'and supplier_supplies_item.Item_itemID = item.itemID '
    query += 'and supplier.supplierID = supplier_supplies_item.Supplier_supplierID; '
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Supplier List': result})


@app.route('/cheapestSeller/<itemId>')
def cheapestSellerList(itemId):
    query = 'select * '
    query += 'from item, supplier, supplier_supplies_item '
    query += f'where item.itemID = {itemId} -- given value '
    query += 'and supplier_supplies_item.Item_itemID = item.itemID '
    query += 'and supplier.supplierID = supplier_supplies_item.Supplier_supplierID '
    query += 'order by item.currentPrice desc '
    query += 'limit 1;'
    cursor = mysql.connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify({'Seller List': result})


if __name__ == '__main__':
    app.run(debug=True)
