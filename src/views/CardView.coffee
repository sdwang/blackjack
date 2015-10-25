class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img width="98px" <% if(!revealed) { %>src="img/card-back.png"<% }else{ %>src="img/cards/<%= rankName %>-<%= suitName %>.png"<% } %></img>' 
  #template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    console.log(@template @model.attributes)
    @$el.append @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

