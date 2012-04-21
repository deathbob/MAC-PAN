require 'securerandom'
require 'json'
require 'matrix'

class Player
  attr_accessor :current_coordinates
  attr_accessor :current_direction
  attr_accessor :character
  attr_accessor :last_move
  attr_accessor :ws
  attr_accessor :id, :alive, :powered_up
  
  def initialize(character_name, ws)
    @active = true
    self.id = SecureRandom.uuid
    self.character = character_name
    self.current_direction = nil
    self.current_coordinates = Vector[0, 0]
    self.ws = ws
    self.alive = true
    self.powered_up = false
  end

  def as_json
    {
      current_x: current_coordinates[0],
      current_y: current_coordinates[1],
      current_direction: last_move,
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
