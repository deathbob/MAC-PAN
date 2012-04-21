class Player extends Backbone.View
	tagName:'span'
	className:'player'
	
	initialize:-> @model.on('change:x change:y', @move)	
	move:=> @$el.css(top: @model.get('current_y'), left: @model.get('current_x'))		
	animate:=>
		
	render:=>
		super
		$('#board').append(@$el)
		@$el.addClass(@model.get("type"))
		@move()
		
MP.PlayerView = Player