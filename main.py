import queries


def wait_for_user():
    input("\nPress Enter to return to the main menu...")


def menu():
    while True:

        print("\nStore Management System")
        print("1. View Products")
        print("2. View Orders with Customers")
        print("3. View Products in Orders")
        print("4. Best Selling Products")
        print("5. Products with Low Stock")
        print("6. Exit")

        choice = input("Select option: ")

        if choice == "1":
            queries.show_products()
            wait_for_user()

        elif choice == "2":
            queries.show_orders_with_customers()
            wait_for_user()

        elif choice == "3":
            queries.show_order_products()
            wait_for_user()

        elif choice == "4":
            queries.best_selling_products()
            wait_for_user()

        elif choice == "5":
            queries.low_stock_products()
            wait_for_user()

        elif choice == "6":
            print("Exiting program.")
            break

        else:
            print("Invalid choice.")
            wait_for_user()


if __name__ == "__main__":
    menu()