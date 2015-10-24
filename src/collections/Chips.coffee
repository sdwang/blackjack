class window.Chips extends Backbone.Collection
  model: Chip

  initialize: (type) ->
    if type == "player"
      @addChips(stack)
    else if type == "dealer"
      @addChips(Math.floor(Math.random() * 100) + 100)

  addChips: (val)->
    @add(new Chip) for n in [0...val] if n
    

  removeChips: (val)->
    @pop() for n in [0...val] if n

  count: -> 
#    @reduce (accumulator, chip) ->
#    accumulator + chip.value
#  , 0
