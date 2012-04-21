class Player extends Backbone.View
	tagName:'span'
	className:'player'
	
	initialize:-> 
		@model.on('change:current_x', @moveHoriz)
		@model.on('change:current_y', @moveVert)
	moveHoriz:=> @$el.css(left: @model.get('current_x'))
	moveVert:=>	@$el.css(top: @model.get('current_y'))
	animate:=>
		
	render:=>
		super
		$('#board').append(@$el)
		@$el.addClass(@model.get("type"))
		@move()
		
MP.PlayerView = Player