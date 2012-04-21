class Player extends Backbone.View
	tagName:'span'
	className:'player'
	
	initialize:-> 
		@model.on('change:current_x', @moveHoriz)
		@model.on('change:current_y', @moveVert)
		@model.on('change:current_direction', @setClass)
		@model.on('destroy', @remove)
		
	moveHoriz:=> @$el.css(left: @model.get('current_x'))
	moveVert:=>	 @$el.css(top: @model.get('current_y'))
	animate:=>
	setClass:=>
		@$el.removeClass("up down left right")
			.addClass(@model.get('current_direction'))
	remove:=>
		super
		delete @model
		
	render:=>
		super
		$('#board').append(@$el)
		@$el.addClass(@model.get("character"))
		@moveHoriz()
		@moveVert()
		
MP.PlayerView = Player