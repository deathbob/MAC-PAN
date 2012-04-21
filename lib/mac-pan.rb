require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH.unshift(File.dirname(__FILE__))  

require "eventmachine"
require "em-websocket"
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
sockets = {}
EventMachine.run {
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8888) do |ws|
    ws.onopen {
      # the 'current' player should have :player => true to separate it from 
      # oppoents.
      puts "Mac-Pan connection open"

#      puts ws.hash # hopefully unique      

      new_player = Player.new(characters.shift)
      state[:players][new_player.id] = new_player
      sockets[ws.hash] = new_player.id # add socket identifier and player id to global so we can delete them when closed.
      ws.send JSON.generate(
        { :type => "create",
          :data => new_player.as_json
        }
      )
    }

    ws.onclose { 
      puts "Connection closed" 
      state[:players].delete{|x| x.id == sockets[ws.hash]}
    }# be nice to delete the player who left from the global state here
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
      

      
#      pacman = state[:players][].detect{|x| x.character == 'pacman'}
      # close_to = lambda{|a, b| }      
      # if pacman.powered_up
      #   # eat ghosts
      # else
      #   state[:players].detect{|x| x.current_coordinates}
      #   #die
      # end
      # poo = state[:players].inject({}){|memo, x| memo[x.character] = x.id; memo}
      # poo['pacman']
      
      player = state[:players][data["id"]]
      desired_position = player.current_coordinates + moves[data["move"].intern]
      
      if (desired_position[0] <= 874 && desired_position[1] <= 570)
        player.current_coordinates += moves[data["move"].intern]      
      end
      

      ws.send JSON.generate({:type => 'update', :data => state[:players].map{|k, v| v.as_json}})
    }
  end
}
