require 'em-websocket'
require 'json'
require_relative 'converter'

@sockets = []

EM.run {
  puts 'starting server'
  EM::WebSocket.run(:host => "0.0.0.0", :port => 1337) do |ws|
  ws.onopen { |handshake|
    @sockets << ws
    puts "WebSocket connection open"
  }

  ws.onclose {
    puts "Connection closed"
    @sockets.delete ws
  }

  ws.onmessage { |msg|
    puts "Recieved: #{msg}"
    response = handle_message(msg)
    @sockets.each do |ws|
      ws.send response
    end
  }
  end

  def handle_message(msg)
    @hashey = JSON.parse(msg)
    return "HASH: #{@hashey}" if false
    return chat(@hashey) if @hashey.has_key? 'chat'
    return new_it_up(@hashey) if @hashey.has_key? 'new'
    return pass_the_message(@hashey) if @hashey.has_key? 'message'
    'hash didn\'t have any known keys'
  end

  def chat(hashey)
    hashey['chat']
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

