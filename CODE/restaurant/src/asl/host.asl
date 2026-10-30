// Agent host in project restaurant

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!request(client, table) : true //host receives the request, notifies the manager that there is a customer
	<- .print("Welcome to the restaurant. Let me find a table.");
	.send(floor_manager, achieve, sayhi).
	
+!asktable : true  // host asks the manager how many tables are available
	<- .print("A table. Are there any tables");
	.send(floor_manager, achieve, tables_left(X)).

+!assigntable : true // assigns the client a table.
	<- .print("Here is your table");
	.send(client, achieve, has(client, table)).

+!notable : true // there is no table so instructs client to try again.
	<- .print("Sorry, please try again.");
	.send(client, achieve, nothas(client, table)).