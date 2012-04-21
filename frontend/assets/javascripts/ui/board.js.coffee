class Board extends Backbone.View
	el:"#board"
	box:{}
	paper: null
	initialize:-> @render()
	render:=>
		super
	
MP.Board = Board