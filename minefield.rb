require 'pry'

class Minefield
  attr_reader :row_count, :column_count

  def initialize(row_count, column_count, mine_count)
    @column_count = column_count
    @row_count = row_count
    @mine_field = Hash.new
    @cleared_field = Hash.new
    @mine_count = mine_count
    count = 1
    coordinate_array = []

    #create minefield with all values initialized to false
    for x in 0..@row_count - 1 do
      for y in 0..@column_count - 1 do
        @mine_field[[x, y]] = false
        @cleared_field[[x, y]] = false
      y += 1
      end
    x += 1
    end

    #generate mine_count # of random
    while coordinate_array.length <= @mine_count - 1
      y_rand = rand(0..@column_count)
      x_rand = rand(0..@row_count)
      coordinate_array << [x_rand, y_rand]
      coordinate_array.uniq
    end

    # #create minefield with mines
    coordinate_array.each do |coordinate|
      @mine_field[coordinate] = true
    end

  end

  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)
    @cleared_field[[row,col]]
  end


  def inbounds?(array)
    if array[0] == 0 || array[1] == 0 || array[0] == @mine_count || array[1] == @mine_count
      return false
    else
      return true
    end

  end

  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)

    @cleared_field[[row,col]] = true

      for x in row - 1 .. row + 1
        for y in col - 1 .. col + 1
          print "\n1. [#{x}. #{y}]\t"
          if @mine_field[[x, y]] == false
            @cleared_field[[x, y]] = true
            print "2. [#{x}. #{y}]\n"
              if inbounds?([x,y])
                clear(x,y)
              end
          end
        end
      end

    @cleared_field[[row,col]]
  end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    #if a field is cleared & @mine_field is true then return true
    for x in 0..@row_count - 1 do
      for y in 0..@column_count - 1 do
        if @cleared_field[[x,y]] && @mine_field[[x,y]]
          return true
          break
        end
      end
    end
    false

  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.

  def all_cells_cleared?
    count_num_of_cells_cleared = @cleared_field.select{|key, value| value == true}.size
    total_cell_count = @column_count * @row_count
    cell_clear_check = total_cell_count - @mine_count == count_num_of_cells_cleared
    return true if !any_mines_detonated? && cell_clear_check
    false

  end

  # Returns the number of mines that are surrounding this cell (maximum of 8).
  def adjacent_mines(row, col)
    count = 0
    for x in row - 1 .. row + 1
      for y in col - 1 .. col + 1
        if @mine_field[[x, y]] == true
          count += 1
        end
      end
    end
    count - 1
  end

  # Returns true if the given cell contains a mine, false otherwise.
  def contains_mine?(row, col)
    @mine_field[[row,col]]
  end
end
