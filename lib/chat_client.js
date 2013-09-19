function init() {
  var username = prompt("Enter username:", "Anonymouse");
  if (!username) { throw_error("Must Enter Username!"); }
  var send_button = document.getElementById("send_button");
  var message_field = document.getElementById("message");
  var connected_button = document.getElementById('connected_button');
  send_button.onclick = send_message;

  var Socket = "MozWebSocket" in window ? MozWebSocket : WebSocket;
  var ws = new Socket("ws://localhost:1337/chat?" + username);
  ws.onmessage = function(evt) {
    process_message(JSON.parse(evt.data));
  };

  ws.onclose = function(event) {
    connected_button.innerHTML = 'Disconnected';
    connected_button.style.color = "Red";
    output("Closed - code: " + event.code + ", reason: " + event.reason + ", wasClean: " + event.wasClean);
    set_connected(false);
  };

  ws.onopen = function() {
    connected_button.innerHTML = 'Connected';
    connected_button.style.color = "ForestGreen";
    set_connected(true);
  };

  function process_message(obj) {
    if (obj.hasOwnProperty('list_update')) {
      update_users(obj.list_update);
    } else if (obj.hasOwnProperty('message')) {
      output(obj.message);
    } else if (obj.hasOwnProperty('error')) {
      throw_error(obj.error.toString());
    }
  }

  function throw_error(string) {
    alert(string);
    window.location.reload(true);
  }

  function output(string) {
    var element = document.getElementById("scroll_list");
    var p = document.createElement("p");
    p.appendChild(document.createTextNode(string.toString()));
    element.appendChild(p);
  }

  function update_users(names) {
    var element = document.getElementById("users");
    if (element.hasChildNodes) {
      while (element.firstChild) {
        element.removeChild(element.firstChild);
      }
    }
    for (var id in names) {
      var p = document.createElement("p");
      p.appendChild(document.createTextNode(names[id]));
      element.appendChild(p);
    }
  }

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

  $('.nano').nanoScroller({
    preventPageScrolling: true
  }); 