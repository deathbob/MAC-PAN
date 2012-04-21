rects = [
	{ x: 64, y: 64, w: 100, h:110 },
	{ x: 64, y: 245, w: 100, h:295 },
	{ x: 232, y: 64, w: 100, h:295 },
	{ x: 232, y: 430, w: 100, h:110 },
	{ x: 400, y: 64, w: 100, h:110 },
	{ x: 400, y: 245, w: 268, h:112 },
	{ x: 400, y: 430, w: 100, h:110 },
	{ x: 570, y: 64, w: 100, h:110 },
	{ x: 570, y: 64, w: 100, h:110 }
	
]

class Board extends Backbone.View
	el:"#board"
	paper: null
	initialize:->
		@render()
		
	render:=>
		super
		@paper = Raphael(@el)
		for rect in rects
			shape = @paper.rect(rect.x, rect.y, rect.w, rect.h, 10)
			shape.attr('stroke-width': 2, 'stroke': 'white', 'fill':'blue')
	
MP.Board = Board