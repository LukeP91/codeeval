require 'pry'

class Labyrinth
  attr_reader :maze

  def initialize(path_to_file)
    @maze = []
    File.open(path_to_file).each_line do |file_line|
      @maze << file_line.chop.split('')
    end
  end

  def solution
    @solution = Maze.new(@maze).best_solution
    mark_solution
    # print_solution
    @maze
  end

  def mark_solution
    @solution.each do |y, x|
      @maze[y][x] = '+'
    end
  end

  def print_solution
    @maze.each do |line|
      puts line.join('')
    end
  end
end

class Maze
  DIRECTIONS = [
    [0, -1], # DOWN
    [-1, 0], # LEFT
    [1, 0], # RIGHT
    [0, 1] # UP
  ].freeze

  def initialize(maze)
    @maze = maze
    @solutions = []
    @dim_y = maze.length - 1
    @dim_x = maze[1].length - 1
    @start = [0, @maze[0].find_index(' ')]
    @finish = [@dim_y, @maze[@dim_y].find_index(' ')]
  end

  def best_solution
    find_solutions
    @solutions.min_by(&:length)
  end

  def find_solutions
    path = [@start]
    find_path(path, @start)
  end

  private

  def find_path(path, current_position)
    path = path.dup
    DIRECTIONS.each do |move|
      next_position = [current_position[0] + move[0], current_position[1] + move[1]]
      next if illegal_move?(path, next_position)
      path << next_position

      if finish?(next_position)
        @solutions << path
        break
      end
      find_path(path, next_position)
    end
  end

  def wall?(position)
    return true if @maze[position[0]][position[1]] == '*'
    false
  end

  def in_path?(path, position)
    path.include?(position) ? true : false
  end

  def out_of_boundry?(next_position)
    next_position[0] < 0 || next_position[1] < 0
  end

  def finish?(position)
    position == @finish ? true : false
  end

  def illegal_move?(path, next_position)
    out_of_boundry?(next_position) || wall?(next_position) || in_path?(path, next_position)
  end
end
