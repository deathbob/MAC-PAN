require 'securerandom'
require './player'
require './board'
require 'ruby-debug'

class Game
  @@games = {}

  attr_reader :id

  def initialize
    @id = SecureRandom.uuid
    @players = {}
    @characters_left = default_characters.clone
    @board = Board.new(File.open("./maps/default.map", "r").read)

    return (@@games[@id] = self)    
  end

  def board
    @board
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
      g.lookupplayer id
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
  def get_character
    raise "Out of characters" if @characters_left.empty?
    @characters_left.shift
  end

  def default_characters
    %w(pacman pinky blinky inky clyde)
  end
end
