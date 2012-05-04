require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH.unshift(File.dirname(__FILE__))  

require "eventmachine"
require "em-websocket"
require 'json'
require 'matrix'
require 'player'

MAP_SIZE = [874, 570]

FPS = 10.0 # frames per second
SKIP_TICKS = 1.0 / FPS # milliseconds per tick of game , as a fractional part of a second.
puts SKIP_TICKS
#TICK_SIZE = 0.1
@state = {
  :players => {}
}

#pinky_position = Vector[0,0]
MAC_PAN_SPEED = 10 # pixels to move per game tick.

@moves = {
  :up => Vector[0,-MAC_PAN_SPEED],
  :down => Vector[0,MAC_PAN_SPEED],
  :left => Vector[-MAC_PAN_SPEED,0],
  :right => Vector[MAC_PAN_SPEED,0]
}
@characters = %w(pacman pinky blinky inky clyde)
@clients = []

def send_state
  # update players to game state

  foo = @state[:players].map{|k, v| v.as_json}
  bar = JSON.generate({:type => 'update', :data => foo})
#  puts bar.inspect    
  @state[:players].each do |k, v|
    v.ws.send bar
  end
end

def move_players
  @state[:players].each do |k, v|
    begin
      v.current_coordinates += @moves[v.last_move.intern] if v.last_move
      pos = v.current_coordinates.to_a
      [0,1].each do |i|
        pos[i] = 0 if v.current_coordinates[i] < 0
        pos[i] = MAP_SIZE[i] if v.current_coordinates[i] > MAP_SIZE[i]
      end
      v.current_coordinates = Vector[pos[0], pos[1]]
    rescue
      puts $!
    end
  end
end

def check_for_collisions
  threshhold = MAC_PAN_SPEED
  players = @state[:players].values
  macpan = nil
  players.each{|x| 
    if x.mac_pan? 
      macpan = x
    end
  }
  # check player collisions
  if macpan
    players = players.reject{|x| x.id == macpan.id}
    players.each do |x|
      cow = x.distance_to(macpan.coords)
      if x.distance_to(macpan.coords) <= threshhold
        if macpan.powered_up
          macpan.ate_somebody(x)
          x.got_eaten
        else
          x.ate_somebody(macpan)
          macpan.got_eaten
        end
      end
    end
  end
  # check powerup collisions
  if macpan
    if macpan.over_powerup
      macpan.power_up!
    end
    if macpan.powered_up
#      puts macpan.powerup_ticks_left
      macpan.power_down!
    end
  end
end

next_game_tick = Time.now.to_f 
Thread.new do
  while true
    begin
      next_game_tick += SKIP_TICKS
      sleep_time = next_game_tick - Time.now.to_f
    
      move_players
      check_for_collisions
      send_state

      if sleep_time > 0
#        puts sleep_time
        sleep sleep_time
      end
    rescue => e
      puts e.backtrace
    end
  end
end

EventMachine.run {
  puts "\nReady for action!"
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8888) do |ws|
    ws.onopen {
      # the 'current' player should have :player => true to separate it from 
      # oppoents.
      puts "Mac-Pan connection open"
      @clients << ws

      new_player = Player.new(@characters.shift, ws)
      new_player.current_coordinates = Vector[10,10]
      @state[:players][new_player.id] = new_player
      ws.send JSON.generate({ :type => "create", :data => new_player.as_json})
    }

    ws.onclose { 
      # be nice to delete the player who left from the global state here
      puts "Connection closed" 
      id = ''
      char_to_add = nil
      @state[:players].each do |k, v|
        if v.ws == ws
          id = k 
          char_to_add = v.character
        end
        @clients.each do |other|
          other.send JSON.generate({ :type => "destroy",  :data => v.as_json })
        end
      end
      if id
        @state[:players].delete(id) 
        @characters = @characters.unshift(char_to_add).compact.uniq
      end
    }
    
    ws.onmessage { |msg|
      puts "Recieved message: #{msg}"
    begin
      data = JSON.parse(msg)
    rescue
      data = []
    end
      player = @state[:players][data["id"]]
      player.last_move = data["move"]
    }
  end
}

