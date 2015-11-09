insert into user (userName, password, firstName, lastName, age, gender, phoneNumber, address, userRole, question, answer)
values ("cust1", "cust1", "cust1_fn", "cust1_ln", 28, "F", "123-456-7891", "777 Lucky Lane, San Jose, CA, 95112", "customer", "What was my high school mascot?", "falcon");

insert into user (userName, password, firstName, lastName, age, gender, phoneNumber, address, userRole, question, answer)
values ("cust2", "cust2", "cust2_fn", "cust2_ln", 50, "M", "198-765-4321", "15234 DB Court, San Jose, CA, 95112", "customer", "What is my mother's maiden name?", "jones");

insert into user (userName, password, firstName, lastName, age, gender, phoneNumber, address, userRole, question, answer)
values ("manager", "manager", "manager_fn", "manager_ln", 18, "M", "408-268-1598", "1582 New York Ave, New York, NY, 12345", "manager", "Favorite city", "Paris");

insert into user (userName, password, firstName, lastName, age, gender, phoneNumber, address, userRole, question, answer)
values ("receptionist", "receptionist", "receptionist_fn", "receptionist_ln", 65, "F", "123-555-7891", "234 Database Court, Ville, PA, 95112", "receptionist", "First pet's name", "Yuki");

insert into user (userName, password, firstName, lastName, age, gender, phoneNumber, address, userRole, question, answer)
values ("roomservice", "roomservice", "roomservice_fn", "roomservice_ln", 50, "M", "888-456-7891", "1859 Trigger Court, City, State, 52584", "room service", "First job", "receptionist");

SELECT * FROM user;