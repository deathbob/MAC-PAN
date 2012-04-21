require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH.unshift(File.dirname(__FILE__))  

require "eventmachine"
require "em-websocket"
require 'json'
require 'matrix'
require 'game'

EventMachine.run {
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8888) do |ws|
    ws.onopen {
      puts "Connection opened"
      @game ||= Game.new
      
      ws.send JSON.generate(
        { :type => "create",
          :data => @game.add_player!.as_json
        }
      )
    }

    ws.onclose { 
      puts "Connection closed"
    }
    
    ws.onmessage { |msg|
      puts "******************\n\nRecieved message: #{msg}"

      begin
        data = JSON.parse(msg)
      rescue
        data = []
      end

      player = Game.lookup_player data["id"]
      game = player.game

      player.current_coordinates = game.process data, player

      doc = game.players.map(&:as_json)

      ws.send JSON.generate({ :type => 'update', 
                              :data => doc })
    }
  end
}
