class Board
  def initialize(board_txt)
    load_board_from! board_txt
    @power_up_active = false
  end

  def move!(old_position, new_position)
    puts "\n * moving from #{old_position.inspect} to #{new_position.inspect}\n"
    move_to_square = lookup(new_position[1], new_position[0])
    return [0, old_position] if move_to_square.nil?
    if move_to_square.traversible?
      if move_to_square.traverse!
        power_up! if move_to_square.is_a?(PowerUp)
        [ move_to_square.score, new_position ]
      else
        [ 0, new_position ]
      end
    else
      [ 0, old_position ]
    end
  end

  def power_up_active?
    !!@power_up_active
  end

private
  def power_up!
    @power_up_active = true
    @last_power_up_at = Time.now
  end

  def lookup(x,y)
    @layout.each do |row|
      row.each do |cell|
        print cell.class.name[0] + " "
      end
      puts "\n"
    end

    @layout[x][y] rescue nil
  end

  def load_board_from! txt
    @layout = txt.split("\n").collect do |line|
      row = []
      line.each_char do |symbol|
        row << case symbol
        when "*"
          Pellet.new
        when "X"
          Wall.new
        when "C"
          Cherry.new
        when "P"
          PowerUp.new
        end
      end

      row
    end
  end
end

class Square
  def initialize
    @traversed = false
  end

  def traverse!
    state = !@traversed
    @traversed = true
    state
  end

  def traversed?
    @traversed
  end

  def traversible?
    true
  end
end

class Pellet < Square
  def score
    10
  end
end

class PowerUp < Square
  def score
    50
  end

  def traverse!
    super
    :power_up
  end
end

class Cherry < Square
  def score
    100
  end
end

class Wall < Square
  def score
    0
  end

  def traversible?
    false
  end  
end
