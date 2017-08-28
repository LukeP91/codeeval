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
    print_solution
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
  # Y X
  DIRECTIONS = [
    [-1, 0], # DOWN
    [0, -1], # LEFT
    [0, 1], # RIGHT
    [1, 0] # UP
  ].freeze

  def initialize(maze)
    @maze = maze
    @solutions = []
    last_row_index = maze.length - 1
    @start_point = [0, @maze[0].find_index(' ')]
    @finish_point = [last_row_index, @maze[last_row_index].find_index(' ')]
  end

  def best_solution
    path = []
    find_path(path, @start_point)
    @solutions.min_by(&:length)
  end

  private

  def find_path(path, current_position)
    path = path.dup
    path << current_position
    DIRECTIONS.each do |move|
      if finish?(current_position)
        @solutions << path
        break
      end
      next_position = [current_position[0] + move[0], current_position[1] + move[1]]
      next if illegal_move?(path, next_position)
      find_path(path, next_position)
    end
  end

  def wall?(position)
    @maze[position[0]][position[1]] == '*'
  end

  def out_of_boundry?(next_position)
    next_position[0] < 0 || next_position[1] < 0
  end

  def finish?(position)
    position == @finish_point
  end

  def illegal_move?(path, next_position)
    out_of_boundry?(next_position) || wall?(next_position) || path.include?(next_position)
  end

  def print_solution(path, maze)
    t_path = path.dup.map(&:dup)
    t_maze = maze.dup.map(&:dup)

    t_path.each do |y, x|
      t_maze[y][x] = '+'
    end

    t_maze.each do |line|
      puts line.join('')
    end
    puts
  end
end
