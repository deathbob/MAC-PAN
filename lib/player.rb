require 'securerandom'
require 'json'

class Player
  attr_accessor :current_coordinates
  attr_accessor :current_direction
  attr_accessor :character
  attr_accessor :id
  attr_accessor :last_move
  attr_accessor :ws
  
  def initialize(character_name, ws)
    self.id = SecureRandom.uuid
    self.character = character_name
    self.current_direction = nil
    self.current_coordinates = Vector[0, 0]
    self.ws = ws
  end

  def as_json
    {
      current_x: current_coordinates[0],
      current_y: current_coordinates[1],
      current_direction: current_direction,
      character: character,
      id: id
    }
  end
end
