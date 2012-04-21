class Player extends Backbone.Model
	socket: null
	defaults: 
		x: 0, 
		y: 0, 
		player: false 
		move: { horiz: null, vert: null }
	
	initialize:-> 
		@view = new MP.PlayerView(model: @)
		@view.render()
	
	save:()=> @socket.send('update', @toJSON())
	
MP.Player = Player