require 'json'

class Pathfinder
  # Breadth-first search
  # Receives a graph represented by adjacency lists of nodes that represent towns,
  # a node to node distance list,
  # the starting point node (source), where the buyer lives.
  def self.doBFS(graph, distances, source)
    bfsInfo = {}

    # Initialize number of hops, distance and predecessor values for each node
    0.upto(graph.length-1) do |i| 
      bfsInfo[i] = {hops: nil, predecessor: nil, distance: nil} 
    end

    # Distance and num hops from source is 0
    bfsInfo[source][:hops] = 0
    bfsInfo[source][:distance] = 0

    #Initailize a queue and systematically get distance and predecessor values for each node
    queue = []
    queue.push(source)

    while !queue.empty? do
      u = queue.shift()
      graph[u].each do |v|
        if bfsInfo[v][:hops].nil?
           # Update number of nodes from source to current node
           bfsInfo[v][:hops] = bfsInfo[u][:hops] + 1
           # Update distance from source to current node
           distance_u_v = get_distance(distances, u, v)
           unless distance_u_v.nil?
             bfsInfo[v][:distance] = bfsInfo[u][:distance] + distance_u_v
            else
              # Instead of weighting the adjacency lists with distances
              # We exepect a separate array.
              # If the disstance hash doesn't contain a value for the u_v key
              # Respond with error explanation.
              return "Distances hash not valid"
            end
           bfsInfo[v][:predecessor] = u
           queue.push(v)
        end
      end
    end
    bfsInfo
  end

  # Distances hash keys are two nodes in numerical order separated by a hyphen
  def self.get_distance(distances, to, from)
    distance_keys = [to, from].sort
    distances["#{distance_keys[0]}-#{distance_keys[1]}"]
  end

  # Return paths from buyers to stockists that have wanted item
  # node_inventory is a look up table of seller towns and inventory
  def self.paths_to_item(graph, distances, source, item, node_inventory)
    # Get index of nodes to distance to source
    bfsInfo = doBFS(graph, distances, source)



    if bfsInfo.is_a?(String)
      return bfsInfo
    else
      # Filter out paths that do not lead to stockists with wanted item
      # Order by least distance from buyer to stockist.
      return  bfsInfo.select{
              |k,v|
              node_inventory[k].is_a?(Array)   &&
              node_inventory[k].include?(item) &&
              !bfsInfo[k][:hops].nil?
            }.sort_by {|key, distance| distance[:distance]}
      end
    end
end