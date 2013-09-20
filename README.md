Event Machine Chat Client
=======================
This is a simple chat application much like IRC. 
I developed it as a demonstration of what can be done using Ruby, Javascript, EventMachine and Web Sockets.

The server-side is a Ruby script using event-machine and web sockets. It recieves and sends json back to the client. 
The client side is Javascript with a simple web interface. It sends and receives json as well.

Originally I started out creating an app that would do remote method invocation by passing json messages from the client to the server.
With this I could create a new object and call methods on that object using method missing. That was cool at first but then I wanted to do something even more useful with the sending and receiving of data over the web socket.
So I changed it into a chat application.

This is the first time I have used event machine for anything. I like it and can see where it can be usefull for some applications.
It reminds me of doing mobile app development.
