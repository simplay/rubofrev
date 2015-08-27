require 'game_field'
require 'point2f'
require 'color'

# known identifiers
# '#' wall (yellow)
# 'p' player (red)
# 't' target (green)
# 'c' chest (blue)
class LevelParser

  BASE_PATH = "src/apps/sokoban"

  # @param grid [Grid] game grid a player is playing
  # @param lvl_name [String] indicating a file in 'maps'
  def initialize(grid, lvl_name)
    @grid = grid
    idx = 1
    file = File.new("#{BASE_PATH}/maps/#{lvl_name}.txt", "r")
    while (line = file.gets)
      parse_at(idx, line)
      idx += 1
    end
    file.close
  end

  def player
    @player
  end

  def target
    @target
  end

  def chest
    @chest
  end

  private

  def parse_at(column_idx, row)
    row_elements = row.chomp.split
    row_elements.each_with_index do |label, row_idx|
      process_row_element(label, row_idx+1, column_idx)
    end
  end

  def process_row_element(label, row_idx, column_idx)
    if label == '#'
      @grid.set_field_at(row_idx, column_idx, GameField.new(Color.yellow, :border, Point2f.new(column_idx, row_idx), nil))

    elsif label == 'p'
      @player = @grid.field_at(row_idx, column_idx)
      @player.color = Color.red
      @player.value = Point2f.new(row_idx, column_idx)

    elsif label == 't'
      @target = @grid.field_at(row_idx, column_idx)
      @target.color = Color.green
      @target.value = Point2f.new(row_idx, column_idx)

    elsif label == 'c'
      @chest = @grid.field_at(row_idx, column_idx)
      @chest.color = Color.blue
      @chest.value = Point2f.new(row_idx, column_idx)
    end
  end

end
