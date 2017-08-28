require 'minitest/autorun'
require './labyrinth'

class LabyrinthTest < Minitest::Test
  def test_goes_throug_straigh_line
    labyrinth = Labyrinth.new('test1.txt')
    solution = load_solution('solution1.txt')
    assert_equal labyrinth.solution, solution
  end

  def test_it_detects_turns
    labyrinth = Labyrinth.new('test2.txt')
    solution = load_solution('solution2.txt')
    assert_equal labyrinth.solution, solution
  end

  def test_that_it_chooses_the_shortests_path
    labyrinth = Labyrinth.new('test4.txt')
    solution = load_solution('solution4.txt')
    assert_equal labyrinth.solution, solution
  end

  def test_code_eval
    labyrinth = Labyrinth.new('test3.txt')
    solution = load_solution('solution3.txt')
    assert_equal labyrinth.solution, solution
  end

  def test_ignores_dead_ends
    labyrinth = Labyrinth.new('test5.txt')
    solution = load_solution('solution5.txt')
    assert_equal labyrinth.solution, solution
  end

  def test_deep_copy_array

  end
  def load_solution(file)
    solution = []
    File.open(file).each_line do |file_line|
      solution << file_line.chop.split('')
    end
    solution
  end
end
