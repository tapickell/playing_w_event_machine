require 'em-websocket'
require 'json'
require_relative 'converter'

@sockets = []
@users = {}

EM.run {
  puts 'starting server'
  EM::WebSocket.run(:host => "0.0.0.0", :port => 1337) do |ws|
    ws.onopen { |handshake|
      @sockets << ws
      @users[handshake.query_string] = ws.object_id
      puts "WebSocket connection open"
      update_user_list
    }

    ws.onclose {
      puts "Connection closed"
      @sockets.delete ws
      @users.delete(@users.key(ws.object_id))
      update_user_list
    }

    ws.onmessage { |msg|
      puts "Recieved: #{msg}"
      response = handle_message(@users.key(ws.object_id), msg)
      @sockets.each { |ws| ws.send response }
    }
  end

  def handle_message(usr, msg)
    return chat(usr, JSON.parse(msg)) if @hashey.has_key? 'chat'
    'hash didn\'t have any known keys'
  end

  def chat(usr, hashey)
    "{ \"message\" : \"#{usr}: #{hashey['chat']}\" }"
  end

  def update_user_list
    @sockets.each { |ws| ws.send "{ \"list_update\" : #{@users.keys} }" }
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

