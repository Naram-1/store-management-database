import mysql.connector

def connect_db():
    return mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Hej123321",
        database="store_management"
    )


# Query 1 - Orders with customer info
def show_orders_with_customers():
    conn = connect_db()
    cursor = conn.cursor(buffered=True)

    query = """
    SELECT Orders.order_id, Customers.customer_id, Customers.name, Orders.order_date, Orders.status
    FROM Orders
    JOIN Customers ON Orders.customer_id = Customers.customer_id;
    """

    cursor.execute(query)

    print("\nOrder ID | Customer ID | Customer Name        | Date       | Status")
    print("-" * 75)
    for order_id, customer_id, name, date, status in cursor.fetchall():
        print(f"{order_id:<8} | {customer_id:<11} | {name:<20} | {date} | {status}")

    conn.close()


# Query 2 - Products inside each order
def show_order_products():
    conn = connect_db()
    cursor = conn.cursor(buffered=True)

    query = """
    SELECT Orders.order_id, Products.name, OrderItems.quantity, OrderItems.unit_price
    FROM OrderItems
    JOIN Orders ON OrderItems.order_id = Orders.order_id
    JOIN Products ON OrderItems.product_id = Products.product_id;
    """

    cursor.execute(query)

    print("\nOrder ID | Product Name              | Qty | Unit Price")
    print("-" * 60)
    for order_id, product, qty, price in cursor.fetchall():
        print(f"{order_id:<8} | {product:<25} | {qty:<3} | {price}")

    conn.close()


# Query 3 - Best selling products
def best_selling_products():
    conn = connect_db()
    cursor = conn.cursor(buffered=True)

    query = """
    SELECT Products.name, SUM(OrderItems.quantity) AS total_sold
    FROM OrderItems
    JOIN Products ON OrderItems.product_id = Products.product_id
    GROUP BY Products.name
    ORDER BY total_sold DESC;
    """

    cursor.execute(query)

    print("\nProduct Name                 | Total Sold")
    print("-" * 40)
    for name, total in cursor.fetchall():
        print(f"{name:<28} | {total}")

    conn.close()


# Query 4 - Total sales revenue
def total_sales_revenue():
    conn = connect_db()
    cursor = conn.cursor(buffered=True)

    query = """
    SELECT SUM(quantity * unit_price) AS total_sales
    FROM OrderItems;
    """

    cursor.execute(query)

    result = cursor.fetchone()
    total_sales = result[0] if result[0] is not None else 0

    print("\nTotal Sales Revenue: {:.2f} SEK".format(total_sales))

    conn.close()


# Query 5 - Low stock products
def low_stock_products():
    conn = connect_db()
    cursor = conn.cursor(buffered=True)

    query = """
    SELECT name, stock_quantity
    FROM Products
    WHERE stock_quantity < 10;
    """

    cursor.execute(query)

    print("\nProduct Name                 | Stock")
    print("-" * 40)
    for name, stock in cursor.fetchall():
        print(f"{name:<28} | {stock}")

    conn.close()


# - Calculate total value of an order (Function)
def calculate_order_total():
    conn = connect_db()
    cursor = conn.cursor(buffered=True)

    order_id = input("Enter Order ID: ").strip()

    if not order_id.isdigit():
        print("Invalid Order ID.")
        conn.close()
        return

    query = "SELECT calculate_order_total(%s);"
    cursor.execute(query, (order_id,))

    result = cursor.fetchone()
    total = result[0] if result[0] is not None else 0

    print(f"\nTotal value for Order {order_id}: {total:.2f} SEK")

    conn.close()


# - Add new product
def add_product():
    import random

    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("SELECT product_id, name, price, stock_quantity FROM Products")
    print("\nExisting Products:")
    print("-" * 60)
    print(f"{'ID':<5} {'Product':<25} {'Price':<10} {'Stock':<10}")
    print("-" * 60)
    for pid, name, price, stock in cursor.fetchall():
        print(f"{pid:<5} {name:<25} {price:<10.2f} {stock:<10}")
    print("-" * 60)

    name = input("Product name: ").strip()
    price = input("Price: ").strip()
    stock = input("Stock quantity: ").strip()

    if not name or not price or not stock:
        print("Invalid input.")
        conn.close()
        return

    try:
        price = float(price)
        stock = int(stock)
    except:
        print("Invalid input format.")
        conn.close()
        return

    sku = "SKU" + str(random.randint(1000, 9999))

    cursor.execute("SELECT category_id FROM Categories")
    category_id = random.choice([row[0] for row in cursor.fetchall()])

    cursor.execute("SELECT supplier_id FROM Suppliers")
    supplier_id = random.choice([row[0] for row in cursor.fetchall()])

    query = """
    INSERT INTO Products (name, sku, price, stock_quantity, category_id, supplier_id, active)
    VALUES (%s, %s, %s, %s, %s, %s, TRUE);
    """

    cursor.execute(query, (name, sku, price, stock, category_id, supplier_id))
    conn.commit()

    print("Product added successfully.")
    conn.close()


# - Update product
def update_product():
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("SELECT product_id, name, price, stock_quantity FROM Products")
    print("\nAvailable Products:")
    print("-" * 60)
    print(f"{'ID':<5} {'Product':<25} {'Price':<10} {'Stock':<10}")
    print("-" * 60)
    for pid, name, price, stock in cursor.fetchall():
        print(f"{pid:<5} {name:<25} {price:<10.2f} {stock:<10}")
    print("-" * 60)

    product_id = input("Product ID to update: ").strip()
    new_price = input("New price: ").strip()
    new_stock = input("New stock quantity: ").strip()

    if not product_id.isdigit() or not new_price or not new_stock:
        print("Invalid input.")
        conn.close()
        return

    try:
        new_price = float(new_price)
        new_stock = int(new_stock)
    except:
        print("Invalid input format.")
        conn.close()
        return

    query = """
    UPDATE Products
    SET price = %s, stock_quantity = %s
    WHERE product_id = %s;
    """

    cursor.execute(query, (new_price, new_stock, product_id))
    conn.commit()

    print("Product updated successfully.")
    conn.close()


# - Create order with stock validation
def create_order():
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("SELECT customer_id, name FROM Customers")
    print("\nAvailable Customers:")
    print("-" * 30)
    for cid, name in cursor.fetchall():
        print(f"{cid}: {name}")
    print("-" * 30)

    customer_id = input("Customer ID: ").strip()
    payment = input("Payment method (Card/Swish/Cash): ").strip()

    if not payment:
        print("Invalid payment method.")
        conn.close()
        return

    cursor.execute("SELECT customer_id FROM Customers WHERE customer_id = %s;", (customer_id,))
    if not cursor.fetchone():
        print("Customer does not exist.")
        conn.close()
        return

    cursor.execute("SELECT product_id, name, price, stock_quantity FROM Products WHERE stock_quantity > 0")
    print("\nAvailable Products:")
    print("-" * 60)
    print(f"{'ID':<5} {'Product':<25} {'Price':<10} {'Stock':<10}")
    print("-" * 60)
    for pid, name, price, stock in cursor.fetchall():
        print(f"{pid:<5} {name:<25} {price:<10.2f} {stock:<10}")
    print("-" * 60)

    cursor.execute(
        "INSERT INTO Orders (customer_id, order_date, status, payment_method) VALUES (%s, CURDATE(), 'Completed', %s);",
        (customer_id, payment)
    )

    order_id = cursor.lastrowid
    items = []

    while True:
        product_id = input("Product ID (or 'done'): ").strip()

        if product_id.lower() == "done":
            break

        if not product_id.isdigit():
            print("Invalid product ID.")
            continue

        quantity = input("Quantity: ").strip()

        if not quantity.isdigit():
            print("Invalid quantity.")
            continue

        quantity = int(quantity)

        cursor.execute("SELECT name, price, stock_quantity FROM Products WHERE product_id = %s;", (product_id,))
        result = cursor.fetchone()

        if not result:
            print("Product not found.")
            continue

        name, price, stock = result

        if stock == 0:
            print("Product is out of stock.")
            continue

        if quantity > stock:
            print(f"Not enough stock. Available: {stock}")
            continue

        cursor.execute(
            "INSERT INTO OrderItems (order_id, product_id, quantity, unit_price) VALUES (%s, %s, %s, %s);",
            (order_id, product_id, quantity, price)
        )

        items.append((product_id, name, quantity, price))

    conn.commit()

    print("\n" + "=" * 55)
    print(f"Order ID: {order_id}")
    print(f"Payment: {payment}")
    print("=" * 55)
    print(f"{'ID':<5} {'Product':<20} {'Qty':<5} {'Price':<10}")
    print("-" * 55)

    total = 0
    for pid, name, qty, price in items:
        total += qty * price
        print(f"{pid:<5} {name:<20} {qty:<5} {price:<10.2f}")

    print("-" * 55)
    print(f"{'TOTAL:':<32} {total:.2f} SEK")
    print("=" * 55)

    conn.close()


# - Show all products
def show_all_products():
    conn = connect_db()
    cursor = conn.cursor(buffered=True)

    cursor.execute("SELECT product_id, name, price, stock_quantity FROM Products")

    print("\nAll Products:")
    print("-" * 60)
    print(f"{'ID':<5} {'Product':<25} {'Price':<10} {'Stock':<10}")
    print("-" * 60)

    for pid, name, price, stock in cursor.fetchall():
        print(f"{pid:<5} {name:<25} {price:<10.2f} {stock:<10}")

    print("-" * 60)

    conn.close()