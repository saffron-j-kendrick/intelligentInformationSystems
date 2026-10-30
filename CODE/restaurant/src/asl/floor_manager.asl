// Agent floor_manager in project restaurant

/* Initial beliefs and rules */

free_tables(10). //initial belief of how many tables are free.
// change the value to 0 to change the outcome
// free_tables(0).

table_available(restaurant) :- free_tables(X) & X > 0. //rule for determining whether or not a table is available

/* Initial goals */

+!start.
/* Plans */

+!sayhi : true 
	<- .print("Customer acknowledged.");
	.send(host, achieve, asktable).

+!tables_left(X) : true //checks how many tables are available
	<- ?free_tables(X);
	 FreeTables = X;
	.print("I am checking tables. ");
	.wait(100);
	-+ free_tables(FreeTables);
	.print( "There are ", FreeTables, " tables.");
	!check_values.

+!check_values : //checks whether number of tables is greater than 0.
	table_available(restaurant) <- .print("We have a table");
	.send(host, achieve, assigntable).


+!check_values : // not greater than zero.
	not table_available(restaurant) <- .print("We do not have a table");
	.send(host, achieve, notable).
	
+!at(table) : true //when customer is at the table, manager updates their belief
	<- ?free_tables(X);
	 FreeTables = X -1;
	 -+ free_tables(FreeTables);
	 .print( "There are "   ,FreeTables, " tables.").
	 
+!left(table) : true //when customer leaves, manager updates their belief
	<- ?free_tables(X);
	 FreeTables = X +1;
	 -+ free_tables(FreeTables);
	 .print( "There are "   ,FreeTables, " tables.").