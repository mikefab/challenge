require 'sinatra'
require './lib/pathfinder'


post '/list_of_sellers' do
  data = JSON.parse(request.body.read)
  # Node to inventory hash keys arrive as strings. Convert them to integers
  node_inventory = Hash[data['node_inventory'].map{|k,v|[ k.to_i, v ]}]

  # Return all paths from buyer to the seller of a wanted item.
  # List is ordered by distance from shortest to longest.
  Pathfinder.paths_to_item(
    data['graph'],
    data['distances'],
    data['source'], 
    data['item'],
    node_inventory
  ).to_json
end

get '/' do

end
