require "bundler/setup"
Bundler.setup
require "eventmachine"
require "em-websocket"
require "ruby-debug"

EventMachine.run {
    EventMachine::WebSocket.start(:host => "127.0.0.1", :port => 8080) do |ws|
        ws.onopen {
          puts "Mac-Pan connection open"
          ws.send "You have hit Mac-Pan"
        }

        ws.onclose { puts "Connection closed" }
        ws.onmessage { |msg|
          puts "Recieved message: #{msg}"
          ws.send "Pong: #{msg}"
        }
    end
}
