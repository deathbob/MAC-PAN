class Socket
	connection: null
	constructor: (options)->
		@connection ||= new WebSocket("ws://#{options.host}:#{options.port}/#{options.path}")
		@connection.onmessage = @receive
	
	receive: (message)=> 
		data = JSON.parse(message.data)
		type = data.type
		console.log "Received #{message.data}"
		MP.mediator.trigger "data:#{type}", data.data
		
	send: (type, data)=> 
		message = JSON.stringify(_.extend({type:'update'}, data))
		console.log "Send: #{message}"
		@connection.send(message)
		
MP.Socket = Socket