require 'securerandom'
require 'player'
require 'board'
#require 'ruby-debug'
require 'matrix'

class Game
  @@games = {}

  attr_reader :id

  SCALE = 54

  def initialize
    @id = SecureRandom.uuid
    @players = {}
    @characters_left = default_characters.clone
    @board = Board.new(File.open("./maps/default.map", "r").read)
    @score = 0

    return (@@games[@id] = self)    
  end

  def process data, player
    case data['type']
    when 'update'
      process_update_for! data, player
    end
  end

  def add_player!
    player = Player.new(get_character)

    @players[player.id] = player
  end

  def remove_player! id
    raise "You must deactivate player first!" if lookup_player(id).active?
    @players.delete(id)
  end

  def players
    @players.values
  end

  def lookup_player id
    @players[id]
  end

  def self.lookup_game id
    @@games[id]
  end

  def self.lookup_player id
    active_games.map { |g|
      g.lookup_player id
    }.compact.first
  end

  def self.lookup_by_player_id id
    active_games.detect { |g| g.lookup_player id }
  end

  def self.active_games
    @@games.values
  end

  def self.count
    @@games.keys.size
  end

private
  def register_score! amount
    @score += amount
  end

  def get_character
    raise "Out of characters" if @characters_left.empty?
    @characters_left.shift
  end

  def default_characters
    %w(pacman pinky blinky inky clyde)
  end

  def process_update_for! data, player
    old = Vector[player.current_coordinates[0], 
                 player.current_coordinates[1]]
    new = old + moves[data["move"].intern]
    score, new_pos = @board.move! old, new

    register_score! score
    Vector[new_pos[0], new_pos[1]]
  end

  def moves
    { :up => Vector[0,-1],
      :down => Vector[0,1],
      :left => Vector[-1,0],
      :right => Vector[1,0]
    }
  end
end
