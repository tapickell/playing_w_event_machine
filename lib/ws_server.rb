require 'em-websocket'
require 'json'
require_relative 'converter'

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
    @hashey = JSON.parse(msg)
    return "HASH: #{@hashey}" if false
    return new_it_up(@hashey) if @hashey.has_key? 'new'
    return pass_the_message(@hashey) if @hashey.has_key? 'message'
    'hash didn\'t have any known keys'
  end

  def new_it_up(hashey)
    @number = Number.new(hashey['new'].to_i)
    'a number has been newed up for your conversion'
  end

  def pass_the_message(hashey)
    message = hashey['message'].to_sym
    if @number
      @number.respond_to?(message) ? @number.send(message) : 'the object doesn\'t respond to that message'
    else
      'the object isn\'t in existance yet'
    end
  end
}

