class Players extends Backbone.Collection
	model: MP.Player
	connection: null
	sync:-> @connection.send(JSON.stringify(@toJSON()))
		
	initialize:->
		MP.mediator.on('receive', @receive)
		@connection ||= new MP.Socket({ host: 'localhost', port: 8888, path: '' });
		
	receive: (msg)=>
		data = JSON.parse(msg)
		for player in data
			curr = @get(player.id)
			if curr 
				curr.set(player)
			else @add(new MP.Player(player))
		@trigger('reset')
	
MP.Players = Players