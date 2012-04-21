mediator = {}
_(mediator).defaults Backbone.Events
mediator._callbacks  = null
mediator.on      = Backbone.Events.on
mediator.off     = Backbone.Events.off
mediator.trigger = Backbone.Events.trigger

# Make subscribe, unsubscribe and publish properties readonly
if Object.defineProperties
	desc = writable: false
	Object.defineProperties mediator,
		subscribe: desc, unsubscribe: desc, publish: desc

# Seal the mediator object
# (extensible: false for the mediator, configurable: false for its properties)
Object.seal? mediator

# Return mediator
MP.mediator = mediator