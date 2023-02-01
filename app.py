from flask import Flask, request
from flask_mysql_connector import MySQL
import hashlib

app = Flask("StoreDataBaseApi")

app.config['MYSQL_HOST'] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""  # 1414
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



if __name__ == '__main__':
    app.run(debug=True)
