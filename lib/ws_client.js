function init() {
  var send_button = document.getElementById('send_button');
  var method_call_field = document.getElementById('method_call');
  var param_one_field = document.getElementById('param_one');
  var param_two_field = document.getElementById('param_two');
  send_button.onclick = send_message;

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
    ws.send("hello server");
    set_connected(true);
  };

  function send_message() {
    var msg = ' ';
    if (method_call_field.value) {
      msg += '{:' + method_call_field.value;
      if (param_one_field.value || param_two_field.value) {
        msg += ' => { '
        if (param_one_field.value) {
          msg += ':param_one => \'' + param_one_field.value + '\'';
        }
        if (param_two_field.value) {
          if (param_one_field.value) {
           msg += ', ';
          }
          msg += ':param_two => \'' + param_two_field.value + '\'';
        }
        msg += ' }}';
      }
    }
    ws.send(msg);
  };

  function set_connected(is_connected) {
    send_button.disabled = !is_connected;
  };
};
