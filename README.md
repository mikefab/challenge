#Technical Engineer Code Challenge#

This service assists buyers locate the nearest seller of a particular good. 

The inputs are:

An undirected graph as adjacency lists where nodes represent towns: [[1],[0, 4, 5], [3, 4, 5], [2, 6], [1, 2], [1, 2, 6], [3, 5],[]]
An index of distances between neighbors where {"1-4": 43} indicates that node 1 is 43 km from node 4 and vice-versa
A source node where the buyer is located
A look up table of seller towns and inventory
The item the buyer wants

Post json parameters to /list_of_sellers.

Example: 

curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"graph": [[1],[0, 4, 5], [3, 4, 5], [2, 6], [1, 2], [1, 2, 6], [3, 5],[]], "distances": {"0-1": 23, "1-4": 43, "1-5": 32, "2-3": 12, "2-4": 432, "2-5": 54, "3-6": 13, "5-6": 65}, "source": 3, "item": "gas", "node_inventory": { "0": "buyer", "4": ["water", "eggs", "gas"], "6": ["water", "eggs", "gas"]}}' localhost:9292/list_of_sellers

You can also post live to http://mighty-journey-2234.herokuapp.com/list_of_sellers

The output from this post is an array of towns that contain the item ordered by proximity to the buyer: [[6,{"hops":1,"predecessor":3,"distance":13}],[4,{"hops":2,"predecessor":2,"distance":444}]]

Start server with: bundle exec rackup

#Code#
- app.rb
- lib/pathfinder.rb
- test.rb I had difficulty with the test suite and decided to roll my own. 
