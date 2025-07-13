import psycopg2

def time_str_format(start_hr, start_min, end_hr, end_min):
  start_min_str = str(int(start_min))
  end_min_str = str(int(end_min))
  if len(start_min_str) == 1:
    start_min_str = '0' + start_min_str
  if len(end_min_str) == 1:
    end_min_str = '0' + end_min_str
  return str(start_hr) + ':' + start_min_str + '-' + str(end_hr) + ':' + end_min_str

# Opening menu for options
def menu_prompts():
    print()
    print("Welcome to Carrot option menu:")
    print("1. View all consumers")
    print("2. View all restauraunts")
    print("3. View all suppliers")
    print("4. View all consumer orders")
    print("5. Create a new consumer")
    print("6. View all restauraunt suppliers")
    print("7. Exit Carrot")
    return input("Enter the number for your option: ")

conn = psycopg2.connect(dbname="carrot")
cur = conn.cursor()

while True:
    fac = menu_prompts()
    print()

    # View all consumers
    if fac == '1':
        consumer_query = """
        SELECT consumer_id, consumer_first_name, consumer_last_name, age, contact_info, dietary_restrictions
        FROM consumer;
        """
        try:
            cur.execute(consumer_query)
            print(f"{'ID':<10} {'First Name':<15} {'Last Name':<15} {'Age':<5} {'Contact Info':<15} {'Dietary Restrictions':<20}")
            print("-" * 90)
            for row in cur:
                print(f"{row[0]:<10} {row[1]:<15} {row[2]:<15} {row[3]:<5} {row[4]:<15} {row[5] if row[5] else 'None':<20}")
        except psycopg2.Error as e:
            print("Error fetching consumers")
            print(e)
            conn.rollback()

    # View all restaurants
    elif fac == '2':
        rest_query = """
        select * from restaurant;
        """
        try:
            cur.execute(rest_query)
            print(f"{'ID':<8} {'Restaurant Name':<20} {'Location':<30} {'Days open':<15} {'Hours open':<15}")
            print("-" * 100)
            for row in cur:
                time = time_str_format(row[4], row[5], row[6], row[7])
                print(f"{row[0]:<8} {row[1]:<20} {row[2]:<30} {row[3]:<15} {time}")
        except psycopg2.Error as e:
            print("Error fetching restaurants")
            print(e)
            conn.rollback()

    # View all suppliers
    elif fac == '3':
        supp_query = """
        select * from supplier;
        """
        try:
            cur.execute(supp_query)
            print(f"{'ID':<8} {'Supplier Type':<15} {'Supplier Name':<30}")
            print("-" * 60)
            for row in cur:
                print(f"{str(row[0]):<8} {str(row[1]):<15} {str(row[2]):<30}")
        except psycopg2.Error as e:
            print("Error fetching suppliers")
            print(e)
            conn.rollback()

    # View all consumer orders
    elif fac == '4':
        consumer_orders_query = """
        SELECT o.order_id, o.consumer_id, c.consumer_first_name, c.consumer_last_name, mi.item_name, mi.price, o.order_date, o.order_hr, o.order_min, o.quantities
        FROM orders o
        JOIN consumer c ON o.consumer_id = c.consumer_id
        JOIN restaurant_menu_list rml ON rml.restaurant_id = o.restaurant_id
        JOIN menu_item mi ON mi.menu_id = rml.menu_id;
        """
        try:
            cur.execute(consumer_orders_query)
            print(f"{'Order ID':<10} {'Consumer ID':<12} {'First Name':<15} {'Last Name':<15} {'Item Name':<20} {'Price':<10} {'Date':<10} {'Time':<12} {'Quantities':<10}")
            print("-" * 130)
            for row in cur:
                formatted_hour = row[7] % 12 or 12
                meridian = "AM" if row[7] < 12 else "PM"
                order_time = f"{formatted_hour:02}:{row[8]:02} {meridian}"
                formatted_price = f"${row[5]:.2f}"
                print(f"{row[0]:<10} {row[1]:<12} {row[2]:<15} {row[3]:<15} {row[4]:<20} {formatted_price:<10} {row[6]:<10} {order_time:<12} {row[9]:<10}")
        except psycopg2.Error as e:
            print("Error fetching consumer orders")
            print(e)
            conn.rollback()

    # Create a new consumer
    elif fac == '5':
        try:
            id = input("Enter the ID of the new consumer: ").strip()
            if not (id.isdigit() and len(id) == 6):
                print("Invalid consumer ID. Must be a 6-digit number.")
                raise ValueError("Returning to main menu.")

            first_name = input("Enter the first name of the new consumer: ").strip().title()
            if not first_name:
                print("Consumer name cannot be empty. Please enter a valid name.")
                raise ValueError("Returning to main menu.")

            last_name = input("Enter the last name of the new consumer: ").strip().title()
            if not last_name:
                print("Consumer name cannot be empty. Please enter a valid name.")
                raise ValueError("Returning to main menu.")

            age = input("Enter the age of the new consumer: ").strip().title()
            if not age:
                age = None

            contact_info = input("Enter the phone number of the new consumer without parentheses or spaces: ").strip()
            if not (contact_info.isdigit() and len(contact_info) == 10):
                print("Phone number cannot be empty. Please enter a valid phone number.")
                raise ValueError("Returning to main menu.")
            else:
                contact_info = float(contact_info)

            print("Enter your dietary restriction if applicable.")
            print("These are the options for dietary restriction type:")
            print("(D) for Dairy")
            print("(N) for Nut")
            print("(G) for Gluten")
            print("(0) for other")
            print("(None) for no dietary restrictions")
            diet = input("Enter the corresponding letter or the word \'None\' for no dietary restrictions: ").strip().title()
            if diet == 'D':
                dietary_restrictions = "dairy"
            elif diet == 'N':
                dietary_restrictions = "nut"
            elif diet == 'G':
                dietary_restrictions = "gluten"
            elif diet == 'O':
                dietary_restrictions = "other"
            elif diet == 'None':
                dietary_restrictions = None

            new_consumer_query = "insert into consumer (consumer_id, consumer_first_name, consumer_last_name, age, contact_info, dietary_restrictions) values (%s, %s, %s, %s, %s, %s)"
            cur.execute(new_consumer_query, (id, first_name, last_name, age, contact_info, dietary_restrictions))
            conn.commit()
            print("Consumer created successfully.")
        except ValueError as e:
            print(e)
            conn.rollback()
        except psycopg2.errors.UniqueViolation:
            print("The consumer ID already exists.")
            conn.rollback()
        except psycopg2.errors.CheckViolation:
            print("The dietary restriction value is invalid.")
            conn.rollback()
        except psycopg2.Error as e:
            print("Other Error")
            print(e)
            conn.rollback()

    elif fac == '6':
        match_query = """
        select * from restaurant natural left join (select * from supply_chain natural left join supplier as t1) as t2;
        """
        try:
            cur.execute(match_query)
            print(f"{'Restaurant ID':<15} {'Restaurant Name':<30} {'Supplier Type':<15} {'Supplier Name':<15}")
            print("-" * 80)
            for row in cur:
                print(f"{str(row[0]):<15} {str(row[1]):<30} {str(row[9]):<15} {str(row[10]):<15}")
        except psycopg2.Error as e:
            print("Error fetching supplier-restaurant pairs")
            print(e)
    elif fac == '7':
        print("Exiting Carrot.")
        break

    else:
        print("Invalid Input Error")
        conn.rollback()

conn.close()