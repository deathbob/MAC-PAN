class Player extends Backbone.Model
	sync:-> MP.Players.sync()
	defaults: 
		x: 0, 
		y: 0, 
		player: false 
		move: { horiz: null, vert: null }
	
	initialize:-> 
		@view = new MP.PlayerView(model: @)
		@view.render()
	
MP.Player = Player