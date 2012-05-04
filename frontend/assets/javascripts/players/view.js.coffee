class Player extends Backbone.View
	tagName:'span'
	className:'player'
	
	initialize:-> 
		@model.on('change:current_x', @moveHoriz)
		@model.on('change:current_y', @moveVert)
		@model.on('change:current_direction', @setClass)
		@model.on('destroy', @remove)
		@model.on('change:score', @updateScore)
		@model.on('change:powered_up', @flashPower)
		
	moveHoriz:=> @$el.css(left: @model.get('current_x'))
	moveVert:=>	 @$el.css(top: @model.get('current_y'))
	animate:=>
	setClass:=>
		@$el.removeClass("up down left right")
			.addClass(@model.get('current_direction'))
	remove:=>
		super
		delete @model
	updateScore:=> 
	    if @model.get('character') is 'pacman'
	        $('#macpan_score').html(@model.get('score'))
        else if @model.get('character') is 'blinky'
	        $('#blinky_score').html(@model.get('score'))
        else if @model.get('character') is 'clyde'
	        $('#clyde_score').html(@model.get('score'))
        else if @model.get('character') is 'pinky'
	        $('#pinky_score').html(@model.get('score'))
        else if @model.get('character') is 'inky'
	        $('#inky_score').html(@model.get('score'))
	        
	flashPower:=>
	    if @model.get('powered_up') is true
	        $('.pacman').css("background-image", "url(/assets/pinky.png)");  
	    if @model.get('powered_up') is false
	        $('.pacman').css("background-image", "url(/assets/pac-man.gif)");  
	render:=>
		super
		$('#board').append(@$el)
		@$el.addClass(@model.get("character"))
		@moveHoriz()
		@moveVert()
		
MP.PlayerView = Player