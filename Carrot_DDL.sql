/* uncomment below if the database has already been created*/
-- drop table restaurant_menu_list;
-- drop table supply_orders;
-- drop table list_ingredients;
-- drop table supply_chain;
-- drop table menu_item;
-- drop table orders;
-- drop table ingredients;
-- drop table consumer;
-- drop table restaurant;
-- drop table supplier;
-- drop table supply_list;
-- drop table menu_list;

create table consumer
	(consumer_id		numeric(6),
	 consumer_first_name		varchar(50) not null,
	 consumer_last_name		varchar(50) not null,
	 age		numeric(3, 0),
	 contact_info		numeric(10) not null, -- conceptualized as phone number w/o country code
	 dietary_restrictions		varchar(100) check (dietary_restrictions in ('dairy', 'nut', 'gluten', 'other')),
	 primary key (consumer_id)
	);

create table restaurant -- idk what we want to make not null here, could be just opened restaurant?
	(restaurant_id		numeric(6),
	 restaurant_name		varchar(50),
	 location		varchar(50),
	 days		varchar(7), -- maybe have tuesday be T, thursday R, Saturday A, and sunday B
	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
	 end_min		numeric(2) check (end_min >= 0 and end_min < 60),
	 primary key (restaurant_id)
	);

create table supplier -- also idk what to make not null here
	(supplier_id		numeric(6),
	 supplier_type		varchar(6) check (supplier_type in ('Veg', 'Dairy', 'Meat', 'Grain', 'Other')),
	 supplier_name		varchar(50),
	 primary key (supplier_id)
	);

create table supply_list
	(supply_order_id		numeric(6),
	 date		numeric(8), -- conceptualizing it as MMDDYYYY
	 quantity		numeric(4,1) check (quantity > 0),
	 primary key (supply_order_id)
	-- we might need ingredient_id in here as a foreign key, unsure
	);

create table ingredients
	(ingredient_id		numeric(6),
	 ingredient_name		varchar(10),
	 stock		numeric(100, 1),
	 price		numeric(6, 2), -- im assuming unit price
	 shelf		numeric(4), -- number of days it can last
	 supplier_id		numeric(6),
	 primary key (ingredient_id),
   foreign key (supplier_id) references supplier (supplier_id) on delete set null
	);

create table menu_list
	(menu_id		numeric(6),
	 primary key (menu_id)
	);

create table menu_item
	(menu_item_id		numeric(6),
	 item_name		varchar(50) not null,
	 price		numeric(6,2) not null,
	 menu_id		numeric(6),
	 primary key (menu_item_id),
	 foreign key (menu_id) references menu_list (menu_id) on delete set null
	);

create table orders
    (order_id       numeric(6),
    quantities      numeric(3,1) not null,
    order_date      numeric(8), -- conceptualizing it as MMDDYYYY
    order_hr        numeric(2) check (order_hr >= 0 and order_hr < 24),
    order_min       numeric(2) check (order_min >= 0 and order_min < 60),
    consumer_id     numeric(6),
    restaurant_id   numeric(6),
    primary key (order_id),
    foreign key (consumer_id) references consumer (consumer_id) on delete set null,
    foreign key (restaurant_id) references restaurant (restaurant_id) on delete set null
    );
	
create table supply_chain
 	(supplier_id numeric(6),
	 restaurant_id numeric(6),
	 primary key (supplier_id, restaurant_id),
	 foreign key (supplier_id) references supplier (supplier_id) on delete set null,
	 foreign key (restaurant_id) references restaurant (restaurant_id) on delete set null
	);

create table list_ingredients
	(ingredient_id numeric(6),
	 supply_order_id numeric(6),
	 primary key (ingredient_id, supply_order_id),
	 foreign key (ingredient_id) references ingredients (ingredient_id) on delete set null,
	 foreign key (supply_order_id) references supply_list (supply_order_id) on delete set null
	);

create table supply_orders
	(supply_order_id numeric(6),
	 restaurant_id numeric(6),
	 primary key (supply_order_id),
	 foreign key (supply_order_id) references supply_list (supply_order_id) on delete set null,
	 foreign key (restaurant_id) references restaurant (restaurant_id) on delete set null
	);

create table restaurant_menu_list
	(menu_id numeric(6),
	 restaurant_id numeric(6),
	 primary key (menu_id),
	 foreign key (menu_id) references menu_list (menu_id) on delete set null,
	 foreign key (restaurant_id) references restaurant (restaurant_id) on delete set null
	);
