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
	MP.Motion = new MP.Motion()
	MP.Players = new MP.Players()
	MP.Players.on('reset', (coll)->
		unless MP.User
			MP.User = coll.detect (player)->  player.get('player') == true
			MP.mediator.on 'devicemotion', (data)->
				MP.User.set('move', { horiz: data.horiz, vert: data.vert })
				MP.User.save()
	)
	
);