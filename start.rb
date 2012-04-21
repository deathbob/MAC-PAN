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
          var obj = {'move': str};
          obj = JSON.stringify(obj);
          ws.send(obj);
          $("ul#messages").append("<li>SENT: "+str+"</li>");
        };

        $(document).keydown(function(e) {
          switch(e.keyCode) { 
           case 38:
            echo('up');
            break;
           case 40:
             echo('down');
             break;
           case 39:
             echo("right");
             break;
           case 37:
             echo("left");
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
