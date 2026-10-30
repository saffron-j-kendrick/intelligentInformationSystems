// Agent client in project restaurant

/* Initial beliefs and rules */

// no initial beliefs about the restaurant, doesn't know if there are tables or not.

/* Initial goals */

!get(table). // initial achievement goals

/* Plans */

// initial goal is triggered

+!get(table) : true
	<- .print("Can I have a table please."); 
	.send(host, achieve, request(client, table)). //send a message to the host
	
+!has(client, table) : true // the host gives the client a table, the client sends a message to the manager that the table is taken
	<- .print("Thank you");
	.send(floor_manager, achieve, at(table));
	!sit(table).

+!nothas(client, table) : true // if they do not get a table, the client waits and then tries again
	<- .print("Never mind");
	.wait(1500);
	!get(table).

+!sit(table) : true // client is at the table
	<- .wait(1000);
	!leave(table).

+!leave(table) : true // the client sends a message that the table is now free
	<- .print("Bye");
	.send(floor_manager, achieve, left(table));
	.wait(1500); //client leaves restaurant, waits and then comes back to restart the loop
	!get(table).