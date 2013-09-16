function init() {
  var username = prompt("Enter username:", "Anonymouse");
  var send_button = document.getElementById("send_button");
  var message_field = document.getElementById("message");
  var connected_button = document.getElementById('connected_button');
  send_button.onclick = send_message;

  function output(string) {
    var element = document.getElementById("messages");
    var p = document.createElement("p");
    p.appendChild(document.createTextNode(string));
    element.appendChild(p);
  }

  var Socket = "MozWebSocket" in window ? MozWebSocket : WebSocket;
  var ws = new Socket("ws://localhost:1337/chat?" + username);
  ws.onmessage = function(evt) {
    output(evt.data);
  };

  ws.onclose = function(event) {
    connected_button.innerHTML = 'disconnected';
    output("Closed - code: " + event.code + ", reason: " + event.reason + ", wasClean: " + event.wasClean);
    set_connected(false);
  };

  ws.onopen = function() {
    connected_button.innerHTML = 'connected';
    set_connected(true);
  };

  function send_message() {
    if (message_field.value) {
      ws.send("{ \"chat\" : \"" + message_field.value + "\" }");
      message_field.value = '';
    }
  };

  function set_connected(is_connected) {
    send_button.disabled = !is_connected;
  };
};
