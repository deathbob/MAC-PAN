#= require_self
#= require ./vendor/underscore
#= require ./vendor/backbone
#= require ./core/mediator
#= require ./core/motion
#= require ./core/socket

(->
	MP = window.MP = {}
)()

$(()->
	MP.Motion = new MP.Motion()
	MP.Motion.on 'devicemotion', (accel)->
	MP.Motion.on 'orientationchange', (orient)-> 
);