function init() {
  var binary_button = document.getElementById("binary_button");
  var hex_button = document.getElementById("hex_button");
  var dec_button = document.getElementById("dec_button");
  var param_one_field = document.getElementById("param_one");
  binary_button.onclick = to_binary;
  hex_button.onclick = to_hexadecimal;
  dec_button.onclick = to_decimal;

  function debug(string) {
    var element = document.getElementById("debug");
    var p = document.createElement("p");
    p.appendChild(document.createTextNode(string));
    element.appendChild(p);
  }

  var Socket = "MozWebSocket" in window ? MozWebSocket : WebSocket;
  var ws = new Socket("ws://localhost:1337/bob?123456");
  ws.onmessage = function(evt) {
    debug("Received: " + evt.data);
  };

  ws.onclose = function(event) {
    debug("Closed - code: " + event.code + ", reason: " + event.reason + ", wasClean: " + event.wasClean);
    set_connected(false);
  };

  ws.onopen = function() {
    debug("connected...");
    set_connected(true);
  };

  function send_message(call) {
    if (param_one_field.value) {
      ws.send("{ \"new\" : \"" + param_one_field.value + "\" }");
      ws.send("{ \"message\" : \"" + call + "\" }");
    }
  };

  function to_binary() {
    send_message('to_binary');
  };

  function to_hexadecimal() {
    send_message('to_hexadecimal');
  };

  function to_decimal() {
    send_message('to_decimal');
  };

  function set_connected(is_connected) {
    binary_button.disabled = !is_connected;
    hex_button.disabled = !is_connected;
    dec_button.disabled = !is_connected;
  };
};
