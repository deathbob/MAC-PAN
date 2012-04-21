class Player extends Backbone.View
	tagName:'span'
	className:'player'
	
	initialize:-> @model.on('change:x change:y', @move)	
	move:=> @$el.css(top: @model.get('y'), left: @model.get('x'))		
	render:=>
		super
		$('#board').append(@$el)
		@$el.addClass("self") if @model.get('player')
		@move()
		
MP.PlayerView = Player