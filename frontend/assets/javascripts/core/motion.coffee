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
		ax = event.accelerationIncludingGravity.x
		ay = -event.accelerationIncludingGravity.y
		MP.mediator.trigger('devicemotion', { x: ax, y: ay });

	onOrientationChange: (event) =>
		orient = if Math.abs(window.orientation) == 90 then 'landscape' else 'portrait'
		MP.mediator.trigger('orientationchange', [orient])
			
MP.Motion = Motion;