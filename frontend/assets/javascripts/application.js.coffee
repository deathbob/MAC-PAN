#= require_self
#= require ./vendor/underscore
#= require ./vendor/backbone
#= require ./vendor/tilt
#= require ./core/mediator
#= require ./core/motion

(->
	MP = window.MP = {}
)()

$(()->
	MP.Motion = new MP.Motion()
	MP.Motion.on 'devicemotion', (accel)->
	MP.Motion.on 'orientationchange', (orient)-> 
);