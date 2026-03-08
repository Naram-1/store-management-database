import mysql.connector

def connect_db():
    return mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Hej123321",
        database="store_management"
    )


def show_products():
    conn = connect_db()
    cursor = conn.cursor()

    query = "SELECT product_id, name, price, stock_quantity FROM Products"
    cursor.execute(query)

    for row in cursor.fetchall():
        print(row)

    conn.close()


def show_orders_with_customers():
    conn = connect_db()
    cursor = conn.cursor()

    query = """
    SELECT Orders.order_id, Customers.name, Orders.order_date
    FROM Orders
    JOIN Customers ON Orders.customer_id = Customers.customer_id
    """

    cursor.execute(query)

    for row in cursor.fetchall():
        print(row)

    conn.close()


def show_order_products():
    conn = connect_db()
    cursor = conn.cursor()

    query = """
    SELECT Orders.order_id, Products.name, OrderItems.quantity
    FROM OrderItems
    JOIN Orders ON OrderItems.order_id = Orders.order_id
    JOIN Products ON OrderItems.product_id = Products.product_id
    """

    cursor.execute(query)

    for row in cursor.fetchall():
        print(row)

    conn.close()


def best_selling_products():
    conn = connect_db()
    cursor = conn.cursor()

    query = """
    SELECT Products.name, SUM(OrderItems.quantity) AS total_sold
    FROM OrderItems
    JOIN Products ON OrderItems.product_id = Products.product_id
    GROUP BY Products.name
    ORDER BY total_sold DESC
    """

    cursor.execute(query)

    for row in cursor.fetchall():
        print(row)

    conn.close()


def low_stock_products():
    conn = connect_db()
    cursor = conn.cursor()

    query = "SELECT name, stock_quantity FROM Products WHERE stock_quantity < 10"

    cursor.execute(query)

    for row in cursor.fetchall():
        print(row)

    conn.close()