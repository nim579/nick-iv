LightboxPhotoModel = Backbone.Model.extend
	initialize: ->
		@view = new LightboxPhotoView model: @
		return @

	open: ->
		@view.render()

	close: ->
		@view.close()

LightboxPhotoView = Backbone.View.extend
	render: ->
		console.log @model.toJSON()

window.Lightbox = Backbone.Collection.extend
	model: LightboxPhotoModel

	openPhoto: (id)->
		@get(id).open()
	