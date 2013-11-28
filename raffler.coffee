window.Raffler =
	Models:{}
	Collections:{}
	Views:{}
	Routers:{}
	init:->
		new Raffler.Routers.Entries
		Backbone.history.start()
$(document).ready ->
	Raffler.init()
class Raffler.Routers.Entries extends Backbone.Router
  routes:
    '': 'index'
    'entries/:id': 'show'
  initialize: ->
    @collection = new Raffler.Collections.Entries()
    @collection.fetch()             
  index: ->
    view = new Raffler.Views.EntriesIndex(collection: @collection)
    $('#container').html(view.render().el)
class Raffler.Views.EntriesIndex extends Backbone.View
  template:  _.template($('#item-template').html())
  events:
    'click #new': 'createEntry'
    'click #draw': 'drawWinner'
    'click .idItem': 'kill'
    'click #reset':'restls'
  initialize: ->
    @collection.on('sync', @render, this)
    @collection.on('add', @render, this)
  render: ->
    $(@el).html(@template(entries: @collection.toJSON()))
    this
  kill: (ev) ->
      console.log $(ev.target).attr('id') # log the jquery selector for debug
      item=@collection.find (model) ->
          model.get("id") is $(ev.target).attr('id')
      item.destroy()
      @.render()
  createEntry: ->
    @collection.create name: $('#new_entry').val()
  drawWinner: ->
    winner = @collection.shuffle()[0]
    if winner
      winner.set(winner: true)
      winner.save()
  restls:->
    @collection.each (item) ->
      item.set winner: false
      item.save()
    
class Raffler.Models.Entry extends Backbone.Model
  defaults: 
    name:''
    winner: false
class Raffler.Collections.Entries extends Backbone.Collection
  model: Raffler.Models.Entry
  localStorage: new Store("backbone-reset")