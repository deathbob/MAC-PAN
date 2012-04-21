# Map

#  M  = MacPan respawn point
#  G  = ghost respawn point
#  .  = path with chomp ball
# ' ' = path without chomp ball
#  X  = wall (can not be in this location)
#  o  = power-up pack

array = File.open("maps/02.txt").readlines
y = 0
board = Board.new()
array.each do |line|
  characters = line.split('')
  x = 0
  characters.each do |character|
    case character
    when "."
      board.pellet_coordinates << [x, y]
      board.valid_coordinates << [x, y]
    when " "
      board.valid_coordinates << [x, y]
    when "G"
      board.ghost_coordinates << [x, y]
      board.valid_coordinates << [x, y]
    when "M"
      board.macpan_coordinates << [x, y]
      board.valid_coordinates << [x, y]
    end
    x += 1
  end
  y += 1
end

