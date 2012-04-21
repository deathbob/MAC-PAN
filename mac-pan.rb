require "bundler/setup"
Bundler.setup
require "eventmachine"
require "em-websocket"
require "ruby-debug"
require 'json'
require 'matrix'


pinky_position = Vector[0,0]
scale = 5
moves = {:up => Vector[0,-scale],
:down => Vector[0,scale],
:left => Vector[-scale,0],
:right => Vector[scale,0]}

EventMachine.run {
  EventMachine::WebSocket.start(:host => "127.0.0.1", :port => 8888) do |ws|
    ws.onopen {
      # the 'current' player should have :player => true to separate it from 
      # oppoents.
      puts "Mac-Pan connection open"
      ws.send JSON.generate([
        { :id => 1, :player => true, :x => 10, :y => 10 },
        { :id => 2, :player => false, :x => 50, :y => 50 }
      ])
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
      puts data[0]["move"]
      # send new coordinates for that character
      pinky_position += moves[data[0]["move"].intern]
      ws.send JSON.generate(
        [
          { player: true, id: 1, x: 10, y:10 },
          { player: false, id: 2, x: pinky_position[0], y: pinky_position[1] },
        ]
      )
      #ws.send JSON.generate({:pinky => {:coordinates =>pinky_position}})
    }
  end
}
