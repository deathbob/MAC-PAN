#= require_self
#= require ./vendor/underscore
#= require ./vendor/backbone
#= require ./vendor/raphael
#= require ./core/mediator
#= require ./core/motion
#= require ./core/socket
#= require ./ui/board
#= require ./players/player
#= require ./players/players
#= require ./players/view

(->
	MP = window.MP =
		config:
			server:
				port: 8888
				host: 'localhost'
				path: '/'
			poll: 100
)()

$(()->

	valid_keys = [38, 37, 40, 39]
	
	MP.Board	 = new MP.Board()
	MP.User 	 = new MP.Player()
	MP.Motion  = new MP.Motion()
	MP.Players = new MP.Players()	
	MP.Socket  = new MP.Socket(MP.config.server)
	
	
	MP.mediator.on 'devicemotion', (data)->
		return false if MP.User is null
		return false if data is null
		MP.User.set('move', { horiz: data.horiz, vert: data.vert })
		MP.User.save()
			
	$(document).on('keydown', (event)->
		if valid_keys.indexOf(event.which) == -1
			return false 
		key = event.which
		move = null
		if key == 37 
			move = "left" 
		else if key == 38 
			move = "up"
		else if key == 39 
			move = 'right'
		else if key == 40 
			move = 'down'
		MP.User.set('move', move)
		MP.User.save()
	)
	
);