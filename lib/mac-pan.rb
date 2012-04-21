require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH.unshift(File.dirname(__FILE__))  

require "eventmachine"
require "em-websocket"
require 'json'
require 'matrix'
require 'player'

MAP_SIZE = [874, 570]
TICK_SIZE = 0.1
state = {
  :players => { 
    
  }
}

pinky_position = Vector[0,0]
scale = 7
moves = {
  :up => Vector[0,-scale],
  :down => Vector[0,scale],
  :left => Vector[-scale,0],
  :right => Vector[scale,0]
}
characters = %w(pacman pinky blinky inky clyde)
clients = []

Thread.new do
  while true
    # apply momentum (and do other game state updates)
    state[:players].each do |k, v|
      begin
        v.current_coordinates += moves[v.last_move.intern] if v.last_move
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

    # update players to game state
    state[:players].each do |k, v|

      v.ws.send JSON.generate({:type => 'update', :data => state[:players].map{|k, v| v.as_json}})
    end

    sleep TICK_SIZE
  end
end

EventMachine.run {
  puts "\nReady for action!"
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8888) do |ws|
    ws.onopen {
      # the 'current' player should have :player => true to separate it from 
      # oppoents.
      puts "Mac-Pan connection open"
      clients << ws

      new_player = Player.new(characters.shift, ws)
      new_player.current_coordinates = Vector[10,10]
      state[:players][new_player.id] = new_player
      ws.send JSON.generate(
        { :type => "create",
          :data => new_player.as_json
      }
      )
    }

    ws.onclose { 
      puts "Connection closed" 
      id = ""
      state[:players].each do |k, v|
        id = k if v.ws == ws
      end
      state[:players].delete(id) if id

    }# be nice to delete the player who left from the global state here
    ws.onmessage { |msg|
      puts "Recieved message: #{msg}"
    begin
      data = JSON.parse(msg)
    rescue
      data = []
    end
      player = state[:players][data["id"]]
      player.last_move = data["move"]
    }
  end
}

