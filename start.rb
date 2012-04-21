require 'sinatra'

get '/' do
  %Q{<html>
  <head>
    <script src='http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js'></script>
    <script>
      $(document).ready(function(){

        ws = new WebSocket("ws://localhost:8080");
        ws.onmessage = function(evt) { $("ul#messages").append("<li>RESPONSE: "+evt.data+"</li>"); };
        ws.onclose = function() { echo("socket closed"); };
        ws.onopen = function() {
          echo("connected...");
        };

        function echo(str){ 
          ws.send(str);
          $("ul#messages").append("<li>SENT: "+str+"</li>");
        };

        $(document).keydown(function(e) {
          switch(e.keyCode) { 
           // User pressed "up" arrow
           case 38:
            echo('up');
            break;

           // User pressed "down" arrow
           case 40:
             echo('down');
             break;
          }
        });
      });
    </script>
  </head>
  <body>
    <h1>TEST PAGE #{Time.now.to_i}</h1>
    <ul id="messages"></ul>
  </body>
</html>}
end
