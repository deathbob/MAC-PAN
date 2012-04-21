require 'securerandom'
require 'JSON'

class Player
  attr_accessor :current_coordinates
  attr_accessor :current_direction
  attr_accessor :type
  attr_accessor :id
  
  def initialize(character_name)
    self.id = SecureRandom.uuid
    self.type = character_name
    self.current_direction = nil
    self.current_coordinates = [0, 0]
  end

  def to_json
    {
      current_x: current_coordinates.first,
      current_y: current_coordinates.last,
      current_direction: current_direction,
      type: type,
      id: id
    }
  end
end
