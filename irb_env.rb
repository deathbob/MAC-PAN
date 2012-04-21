require './game'

@g1 = Game.new
@g2 = Game.new

4.times do
  @g1.add_player!
  @g2.add_player!
end
