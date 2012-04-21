class Socket
	connection: null
	constructor: (options)->
		@connection ||= new WebSocket("ws://#{options.host}:#{options.port}/#{options.path}")
		@connection.onmessage = @receive
		#@connection.onclose 	= @destroy
	
	destroy: (player) => @send('destroy', player.toJSON())
	
	receive: (message)=> 
		data = JSON.parse(message.data)
		type = data.type
		console.log "Received: #{data}"
		MP.mediator.trigger "data:#{type}", [data.data]
		
	send: (type, data)=> 
		message = JSON.stringify(type: type, data: data)
		console.log "Send: #{message}"
		@connection.send(message)
		
MP.Socket = Socket