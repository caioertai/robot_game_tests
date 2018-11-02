require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require_relative 'app'

task default: %i[rubocop spec]

desc 'Look for style guide offenses in your code'
task :rubocop do
  sh 'rubocop --format simple || true'
end

desc 'Open an irb session preloaded with the environment'
task :console do
  require 'pry'

  Pry.start
end

desc 'Start a test game session'
task :game do
  require 'pry'

  o = Square.empty
  x = Square.hole
  squares = [
    [o, o, o, o, x, o, o, o],
    [x, x, x, o, x, o, o, o],
    [o, o, x, o, x, o, o, o],
    [o, o, x, o, x, o, o, o],
    [o, o, x, o, o, o, o, o],
    [o, o, o, x, x, x, o, o],
    [o, o, o, o, o, o, o, o],
    [o, o, o, o, o, o, o, o]
  ]

  BOARD = Board.new(squares: squares)
  ROBOT = Robot.new(board: BOARD)

  Pry.start
end
