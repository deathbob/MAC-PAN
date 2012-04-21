class Socket
	connection: null
	channel: null
	constructor: (options)->
		@connection ||= new WebSocket("ws://#{options.host}:#{options.port}/#{options.path}")
		@channel = "root"
		@connection.onmessage = @receive
	
	receive: (message)=> 
		console.log "Received: #{message.data}"
		MP.mediator.trigger "receive", [message.data]
		
	send: (message)=> 
		console.log "Send: #{message}"
		@connection.send(message)
		
MP.Socket = Socket