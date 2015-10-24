class window.ChipsView extends Backbone.View
  className: 'chips'

  template: _.template '<h3>stack</h3><h4 class="stack"></h4>'

  initialize: ->
    @collection.on 'add remove', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$('.stack').text @collection.count()