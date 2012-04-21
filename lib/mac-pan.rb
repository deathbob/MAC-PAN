require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH.unshift(File.dirname(__FILE__))  

require "eventmachine"
require "em-websocket"
#require "ruby-debug"
require 'json'
require 'matrix'
require 'player'

state = {
  :players => { 
    
  }
}

pinky_position = Vector[0,0]
scale = 5
moves = {
  :up => Vector[0,-scale],
  :down => Vector[0,scale],
  :left => Vector[-scale,0],
  :right => Vector[scale,0]
}

characters = %w(pacman pinky blinky inky clyde)

EventMachine.run {
  EventMachine::WebSocket.start(:host => "127.0.0.1", :port => 8888) do |ws|
    ws.onopen {
      # the 'current' player should have :player => true to separate it from 
      # oppoents.
      puts "Mac-Pan connection open"

      new_player = Player.new(characters.shift)
      state[:players][new_player.id] = new_player

      ws.send JSON.generate(
        { :type => "create",
          :data => new_player.as_json
        }
      )
    }

    ws.onclose { puts "Connection closed" }
    ws.onmessage { |msg|
      puts "Recieved message: #{msg}"
    begin
      data = JSON.parse(msg)
    rescue
      data = []
    end
      #do somethin
      #ws.send JSON.generate(data)
      puts data["id"]
      # send new coordinates for that character
      
      player = state[:players][data["id"]]
      player.current_coordinates += moves[data["move"].intern]

      ws.send JSON.generate({:type => 'update', :data => [player.as_json]})
    }
  end
}
