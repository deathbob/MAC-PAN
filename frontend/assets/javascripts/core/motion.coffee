class Motion
	subscribers: {}
	
	constructor:->
		window.addEventListener('devicemotion', @onDeviceMotion, false);
		$(window).on('orientationchange', @onOrientationChange);
	
	on: (type, callback) ->
		handlers = @subscribers[type]
		return if _(handlers).include(callback)
		@subscribers[type] ||= []
		@subscribers[type].push callback
		MP.mediator.on type, callback, this
		
	off: (type, callback)->
		handlers = @subscribers[name]
		if handlers
			index = _(handlers).indexOf handler
			handlers.splice index, 1 if index > -1
			delete @subscribers[type] if handlers.length is 0
		MP.mediator.off type, handler
	
	cleanup: ->
		return unless @subscribers
		for own type, handlers of @subscribers
			for handler in handlers 
				MP.mediator.unsubscribe type, handler
			
	onDeviceMotion: (event) =>
		ax = event.accelerationIncludingGravity.x.toFixed(1);
		ay = -event.accelerationIncludingGravity.y.toFixed(1);
		az = event.accelerationIncludingGravity.z.toFixed(1);
		if Math.abs(ay) > Math.abs(az)
			if ay < 0 
				moves = 'left'
			else 
				moves = "right"
		else
			if az < 0
				moves = 'up'
			else 
				moves = 'down'
		# tilt = if ay < 0 then "left" else "right"
		# yaw  = if -ax < 4.5  then "up" else "down"
		# moves = if ax < 3 and ax > -3 then yaw else tilt
		MP.mediator.trigger 'devicemotion', { x: ax, y: ay, z: az, horiz: tilt, vert: yaw, moves: moves }

	onOrientationChange: (event) =>
		orient = if Math.abs(window.orientation) == 90 then 'landscape' else 'portrait'
		MP.mediator.trigger('orientationchange', [orient])
			
MP.Motion = Motion;