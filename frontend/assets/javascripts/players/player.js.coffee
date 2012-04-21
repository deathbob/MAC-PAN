class Player extends Backbone.Model
	socket: null
	defaults: 
		current_x: 0 
		current_y: 0
		move: null
		character: null
		current_direction: null
	
	initialize:-> 
		@view = new MP.PlayerView(model: @)
		MP.mediator.on('data:create', @setup)
	
	setup:(data)=> 
		@set(data)
		@view.render()
		
	save:()=> MP.Socket.send('update', @toJSON())
	
MP.Player = Player