class Player extends Backbone.Model
	socket: null
	defaults: 
		current_x: 0 
		current_y: 0
		move: null
		type: null
		current_direction: null
	
	initialize:-> 
		@view = new MP.PlayerView(model: @)
		@view.render()		
		MP.mediator.on('data:create', @setup)
	
	setup:(data)=> @set(data)
	save:()=> MP.Socket.send('update', @toJSON())
	
MP.Player = Player