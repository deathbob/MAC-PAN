require 'securerandom'
require './player'

class Game
  @@games = {}

  attr_reader :id

  def initialize
    @id = SecureRandom.uuid
    @players = {}
    @characters_left = default_characters.clone

    return (@@games[@id] = self)    
  end

  def add_player!
    player = Player.new(get_character)

    @players[player.id] = player
  end

  def players
    @players.values
  end

  def find_player id
    @players[id]
  end

  def self.find_game id
    @@games[id]
  end

  def self.find_player id
    active_games.map { |g|
      g.find_player id
    }.compact
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
