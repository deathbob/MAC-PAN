require 'securerandom'
require 'JSON'
require 'matrix'

PIXEL_X = 56
PIXEL_Y = 59

class Player
  attr_accessor :current_coordinates
  attr_accessor :current_direction
  attr_accessor :character
  attr_accessor :id
  
  def initialize(character_name)
    @active = true
    self.id = SecureRandom.uuid
    self.character = character_name
    self.current_direction = nil
    self.current_coordinates = Vector[0, 0]
  end

  def as_json
    {
      current_x: (current_coordinates[0] * PIXEL_X),
      current_y: (current_coordinates[1] * PIXEL_Y),
      current_direction: current_direction,
      character: character,
      id: id
    }
  end

  def game
    Game.lookup_by_player_id id
  end

  def destroy!
    @active = false

    game.remove_player! id
  end

  def active?
    @active
  end
end
