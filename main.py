import queries

def wait_for_user():
    input("\nPress Enter to return to the main menu...")

def menu():
    while True:
        print("\nStore Management System")
        print("1. View Orders with Customers")
        print("2. View Products in Orders")
        print("3. Best Selling Products")
        print("4. Total Sales Revenue")
        print("5. Products with Low Stock")
        print("6. Calculate Order Total")
        print("7. Add Product")
        print("8. Update Product")
        print("9. Create Order")
        print("10. Show All Products Stock")
        print("11. Exit")

        choice = input("Select option: ")

        if choice == "1":
            queries.show_orders_with_customers()
            wait_for_user()

        elif choice == "2":
            queries.show_order_products()
            wait_for_user()

        elif choice == "3":
            queries.best_selling_products()
            wait_for_user()

        elif choice == "4":
            queries.total_sales_revenue()
            wait_for_user()

        elif choice == "5":
            queries.low_stock_products()
            wait_for_user()

        elif choice == "6":
            queries.calculate_order_total()
            wait_for_user()

        elif choice == "7":
            queries.add_product()
            wait_for_user()

        elif choice == "8":
            queries.update_product()
            wait_for_user()

        elif choice == "9":
            queries.create_order()
            wait_for_user()

        elif choice == "10":
            queries.show_all_products()
            wait_for_user()

        elif choice == "11":
            print("Exiting program.")
            break

        else:
            print("Invalid choice.")
            wait_for_user()

if __name__ == "__main__":
    menu()