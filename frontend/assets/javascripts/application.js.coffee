#= require_self
#= require ./vendor/underscore
#= require ./vendor/backbone
#= require ./core/mediator
#= require ./core/motion
#= require ./core/socket
#= require ./players/player
#= require ./players/players
#= require ./players/view

(->
	MP = window.MP = {}
)()

$(()->

	valid_keys = [38, 37, 40, 39]
	init = false
	MP.User = null
	MP.Motion = new MP.Motion()
	MP.Players = new MP.Players()
	MP.Players.on('reset', ()->
		MP.User = MP.Players.detect (player)->  player.get('player') == true
	)
	
	MP.mediator.on 'devicemotion', (data)->
				return false if MP.User is null
				return false if data is null
				MP.User.set('move', { horiz: data.horiz, vert: data.vert })
				MP.User.save()
			
			$(document).on('keyup', (event)->
				return false if MP.User is null or valid_keys.indexOf(event.which) == -1
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