if  RUBY_VERSION.to_f < 1.9
  require 'rubygems'
end 
require 'eventmachine'
require 'em-websocket'
require 'json'

class Player

    attr_accessor :socket

    def initialize(socket)
        @socket = socket
    end

    def send(msg)
        @socket.send msg
    end

    def hasSocket(socket)
        @socket == socket
    end

end

@allPlayers = [];

EM.run {
  EM::WebSocket.run(:host => "localhost", :port => 8090) do |ws|
    
    ws.onopen { |handshake|
        p = Player.new ws
        @allPlayers.push(p);
        
        puts "WebSocket connection open"
        # puts json: handshake

        # Access properties on the EM::WebSocket::Handshake object, e.g.
        # path, query_string, origin, headers

        # Publish message to the client
        ws.send "Hello Client, you connected to #{handshake.path}"
    }

    ws.onclose {
        @allPlayers.delete_if {|p| p.socket == ws};
        puts "Connection closed"
    }

    ws.onmessage { |msg|
        puts "Recieved message: #{msg}"
        @allPlayers.each do |p|
            p.send("Pong: #{msg}")
        end
    }
  end
}