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
  attr_accessor :score
  attr_accessor :powerup_ticks_left
  
  def initialize(character_name, ws)
    @active = true
    self.id = SecureRandom.uuid
    self.character = character_name
    self.current_direction = nil
    self.current_coordinates = Vector[rand(874), rand(570)]
    self.ws = ws
    self.alive = true
    self.powered_up = false
    self.score = 0
    self.powerup_ticks_left = 0
  end
  
  def reset_coordinates
    self.current_coordinates = Vector[0, 0]
  end
  
  def coords
    current_coordinates
  end

  def as_json
    {
      current_x: current_coordinates[0],
      current_y: current_coordinates[1],
      current_direction: last_move,
      character: character,
      id: id,
      score: score,
      powered_up: powered_up
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
  
  def mac_pan?
    self.character == 'pacman'
  end
  
  def my_x
    self.current_coordinates[0]
  end
  
  def my_y
    self.current_coordinates[1]
  end
  
  def distance_to(coord_vector)
    foo = (my_x - coord_vector[0]) ** 2
    bar = (my_y - coord_vector[1]) ** 2    
    Math.sqrt(foo + bar)
  end
  
  def ate_somebody(who = nil)
    unless who.id == self.id # no points awarded if you eat yourself ...
      self.score += 10 
    end
  end
  
  def got_eaten
    reset_coordinates
  end
  
  def powerup_locations
    [
      [5,5],
      [870, 5],
      [5, 565],
      [870, 565]
    ]    
  end

  def over_powerup
    powerup_locations.each do |x|
      if distance_to(x) <= 10
        puts "POWERING UP"
        return true
      end
    end
    return false
  end
  
  def power_up!
    self.powered_up = true
    self.powerup_ticks_left = 36
  end
  
  def power_down!
    puts "Powering down"
#    binding.pry
    self.powerup_ticks_left = (self.powerup_ticks_left - 1)
    if @powerup_ticks_left <= 0
      self.powered_up = false
    end
  end
end










