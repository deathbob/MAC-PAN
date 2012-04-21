class Players extends Backbone.Collection
	model: MP.Player
	initialize:-> 
		MP.mediator.on('data:update', @receive)
		MP.mediator.on('data:destroy', @drop)
	
	drop: (data)=> 
		player = @get(data.id)
		player.destroy() if player
		
	receive: (data)=>
		console.log data
		for player in data
			curr = @get(player.id)
			if curr 
				curr.set(player)
			else @add(new MP.Player(player))
		@trigger('reset')
	
MP.Players = Players