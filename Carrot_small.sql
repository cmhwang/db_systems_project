delete from restaurant_menu_list;
delete from supply_orders;
delete from list_ingredients;
delete from supply_chain;
delete from menu_item;
delete from orders;
delete from ingredients;
delete from consumer;
delete from restaurant;
delete from supplier;
delete from supply_list;
delete from menu_list;

-- consumer tuple
insert into consumer values ('192834', 'Sarah', 'Johnson', '25', '1234567890', 'gluten');
insert into consumer values ('182945', 'Michael', 'Smith', '32', '2345678901', 'nut');
insert into consumer values ('172836', 'Emily', 'Davis', '20', '3456789012', 'dairy');
insert into consumer values ('162837', 'David', 'Williams', '45', '4567890123', 'other');
insert into consumer values ('152839', 'Jessica', 'Brown', '30', '5678901234', null);

-- restaurant tuple
insert into restaurant values ('000000', 'Aromas', 'Colonial Williamsburg', 'MTWRFAB', '8', '0', '22', '0');
insert into restaurant values ('000001', 'Mellow Mushroom', 'Colonial Williamsburg', 'MTWRF', '7', '30', '20', '30');
insert into restaurant values ('000002', 'Wawa', 'Richmond Road', 'MWF', '10', '0', '18', '0');
insert into restaurant values ('000003', 'Amiraj', 'Monticello Ave', 'MWF', '11', '0', '23', '0');
insert into restaurant values ('000004', 'Ichiban', 'New Town', 'TRAB', '9', '0', '21', '30');

-- supplier tuple
insert into supplier values ('300000', 'Veg', 'cabbage_farm_1');
insert into supplier values ('300001', 'Dairy', 'milk_farm_1');
insert into supplier values ('300002', 'Meat', 'meat_ranch_1');
insert into supplier values ('300003', 'Grain', 'rice_farm');
insert into supplier values ('300004', null, null);

-- supply_list tuple
insert into supply_list values ('201234', '11152024', '50');
insert into supply_list values ('202345', '11292024', '25');
insert into supply_list values ('203456', '12012024', '30');
insert into supply_list values ('202347', '12022024', '20');
insert into supply_list values ('202348', '12052024', '45');

-- ingredients tuple
insert into ingredients values ('000010', 'Carrot', '100', '2', '21', '300000');
insert into ingredients values ('000011', 'Cream', '50', '6', '14', '300001');
insert into ingredients values ('000012', 'Chicken', '10', '12', '14', '300002');
insert into ingredients values ('000013', 'Rice', '90', '3', '600', '300003');
insert into ingredients values ('000014', 'Orange', null, '0.77', '15', null);

-- menu_list tuple
insert into menu_list values ('100001');
insert into menu_list values ('100002');
insert into menu_list values ('100003');
insert into menu_list values ('100004');
insert into menu_list values ('100005');

-- menu_item tuple
insert into menu_item values ('200001', 'Mediterranean Melt', '10.99', '100001');
insert into menu_item values ('200002', 'Cheese Pizza', '13.99', '100002');
insert into menu_item values ('200003', 'Chicken Salad', '8.99', '100003');
insert into menu_item values ('200004', 'Naan', '3.99', '100004');
insert into menu_item values ('200005', 'Mochi', '5.95', '100005');

-- order tuple
insert into orders values ('120948', '99', '12022024', '8', '22', '192834', '000000');
insert into orders values ('298940', '50', '11052024', '20', '5', '182945', '000001');
insert into orders values ('209447', '62', '12082024', '3', '34', '172836', '000002');
insert into orders values ('485722', '0', '11182024', '21', '2', '162837', '000003');
insert into orders values ('291034', '13', '11312024', '15', '10', '152839', '000004');

-- supply_chain tuple
insert into supply_chain values ('300000', '000000');
insert into supply_chain values ('300001', '000001');
insert into supply_chain values ('300002', '000002');
insert into supply_chain values ('300003', '000003');
insert into supply_chain values ('300004', '000004');

-- list_ingredients tuple
insert into list_ingredients values ('000010', '201234');
insert into list_ingredients values ('000011', '202345');
insert into list_ingredients values ('000012', '203456');
insert into list_ingredients values ('000013', '202347');
insert into list_ingredients values ('000014', '202348');

-- supply_orders tuple
insert into supply_orders values ('201234', '000000'); -- Aromas
insert into supply_orders values ('202345', '000001');  -- Mellow Mushroom
insert into supply_orders values ('203456', '000002'); -- Wawa
insert into supply_orders values ('202347', '000003'); -- Amiraj
insert into supply_orders values ('202348', '000004'); -- Ichiban

-- restaurant_menu_list tuple
insert into restaurant_menu_list values ('100001', '000000'); -- Aromas
insert into restaurant_menu_list values ('100002', '000001'); -- Mellow Mushroom
insert into restaurant_menu_list values ('100003', '000002'); -- Wawa
insert into restaurant_menu_list values ('100004', '000003'); -- Amiraj
insert into restaurant_menu_list values ('100005', '000004'); -- Ichiban