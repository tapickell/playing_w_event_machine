var send_button;
var method_call_field;
var param_one_field;
var param_two_field;

function init() {
  send_button = document.getElementById('send_button');
  method_call_field = document.getElementById('method_call');
  param_one_field = document.getElementById('param_one');
  param_two_field = document.getElementById('para_two');
  send_button.onclick = send_message();

  function debug(string) {
    var element = document.getElementById("debug");
    var p = document.createElement("p");
    p.appendChild(document.createTextNode(string));
    element.appendChild(p);
  }

  var Socket = "MozWebSocket" in window ? MozWebSocket : WebSocket;
  var ws = new Socket("ws://localhost:8080/bob?123456");
  ws.onmessage = function(evt) {
    debug("Received: " + evt.data);
    set_connected(true);
  };

  ws.onclose = function(event) {
    debug("Closed - code: " + event.code + ", reason: " + event.reason + ", wasClean: " + event.wasClean);
    set_connected(false);
  };

  ws.onopen = function() {
    debug("connected...");
    ws.send("hello server");
  };

  send_message = function() {

    ws.send(msg);
  };

  set_connected(is_connected) {
    send_button.disabled = is_connected;
  };
};
