require 'em-websocket'

EM.run {
  puts 'starting server'
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|
  ws.onopen { |handshake|
    puts "WebSocket connection open"

    # Access properties on the EM::WebSocket::Handshake object, e.g.
    # path, query_string, origin, headers

    # Publish message to the client
    ws.send "Hello Client, you connected to #{handshake.path}"
    ws.send "Query: #{handshake.query_string}"
  }

  ws.onclose { puts "Connection closed" }

  ws.onmessage { |msg|
    puts "Recieved: #{msg}"
    ws.send handle_message(msg)
  }
  end

  def handle_message(msg)
    msg
  end
}

