require 'net/http'
require './lib/pathfinder'

class Test

  def self.test_is_valid(node, test_results, kind )
    if test_results[0][0] === node
      puts "#{kind} test passes"
    else
      puts "#{kind} test fails"
    end

  end

  def self.test_paths_to_item(graph, distances, source, item, node_inventory)
    Pathfinder.paths_to_item(
      graph,
      distances,
      source, 
      item,
      node_inventory
    )
  end

  graph          = [[1],[0]]
  distances      = {'0-1' => 23}
  source         = 0
  item           = 'gas'
  node_inventory = { 0 => [], 1 => ['water', 'eggs', 'gas']}

  test_results = Test.test_paths_to_item(graph, distances, source, item, node_inventory)
  puts test_is_valid(1, test_results, 'Base' )



  graph          = [[1, 2],[0, 1], [0]]
  distances      = {'0-1' => 43, '0-2' => 11}
  source         = 0
  item           = 'gas'
  node_inventory = { 0 => [], 1 => ['water', 'eggs', 'gas'], 2 => ['water', 'eggs', 'gas']}

  test_results = Test.test_paths_to_item(graph, distances, source, item, node_inventory)
  puts test_is_valid(2, test_results, 'Slightly more advanced')



end