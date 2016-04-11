Simple WebSocket test app.

There are two servers:
  -Run the ruby server with 'rails s' the way you usually would to host the html pages.
  -Run the /scripts/WebSocketServer.rb file with ruby to setup listening for web sockets on a port.  The javascirpt on the pages will ping this port.