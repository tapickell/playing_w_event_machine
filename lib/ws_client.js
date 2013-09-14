function init() {
  var send_button = document.getElementById("send_button");
  var create_button = document.getElementById("create_button");
  var method_call_field = document.getElementById("method_call");
  var param_one_field = document.getElementById("param_one");
  send_button.onclick = send_message;
  create_button.onclick = create_object;

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
  };

  ws.onclose = function(event) {
    debug("Closed - code: " + event.code + ", reason: " + event.reason + ", wasClean: " + event.wasClean);
    set_connected(false);
  };

  ws.onopen = function() {
    debug("connected...");
    set_connected(true);
  };

  function create_object() {
    if (param_one_field.value) {
      ws.send("{ \"new\" : \"" + param_one_field.value + "\" }");
    }
  }

  function send_message() {
    if (method_call_field.value) {
      ws.send("{ \"message\" : \"" + method_call_field.value + "\" }");
    }
  };

  function set_connected(is_connected) {
    send_button.disabled = !is_connected;
    create_button.disabled = !is_connected;
  };
};
