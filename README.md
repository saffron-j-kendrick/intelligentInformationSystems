# intelligentInformationSystems

A simple multi-agent scenario.

The customer enters the restaurant and requests a table. The host
greets the customer and notifies the manager. The manager gives the host the go-ahead to find
a table. The host then asks the manager whether there is a table available, and the manager
communicates this back to the host. The host either assigns the customer a table, or tells them
to try again. The client is set on a loop; after leaving the restaurant, they return after 1500ms,
and if they do not get a table, they will come back to try again
