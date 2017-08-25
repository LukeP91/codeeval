require "minitest/autorun"
require 'pry'

class LabyrinthTest < Minitest::Test
  def test_that_it_stores_labyrinth_as_array
  end

  def test_that_it_can_find_start
    labyrinth = Labyrinth.new('test1.txt')
    array = Array.new(5) { ['*', '+', '*']}
    assert_equal labyrinth.start, array
  end
end

class Labyrinth
  attr_reader :schema

  def initialize(path_to_file)
    @schema = []
    File.open(path_to_file).each_line do |file_line|
      @schema << file_line.chop.split('')
    end
  end

  def solution
    @schema.each do |line|
    end
  end
end

class SolutionPath
  def initialize
    @solution_nodes = []
  end

  def current_node
    @solution_nodes.last
  end

  def add_next_node(next_node)
    current_node.child = next_node
    next_node.parent = current_node
    @solution_nodes << next_node
  end

  def solution_length
    @solution_nodes.size
  end
end

class Node
  attr_accessor :child, :parent

  def initalize(x:, y:)
    @x = x
    @y = y
  end
end
