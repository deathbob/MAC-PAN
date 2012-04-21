class Socket
	connection: null
	channel: null
	constructor: (options)->
		@connection ||= new WebSocket("ws://#{options.host}:#{options.port}/#{options.path}")
		@channel = "root"
		@connection.onmessage = @receive
	
	receive: (message)=> MP.mediator.trigger "receive", [message.data]
	send: (message)=> @connection.send(message)
		
MP.Socket = Socket