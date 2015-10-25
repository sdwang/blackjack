class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @checkBust()
    @last()


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  score: ->
    if @scores()[1] > @scores()[0] and @scores()[1] <= 21
      @scores()[1]
    else
      @scores()[0]


  checkBust: ->
    if @scores()[0] > 21
      @trigger('bust', @)

  stand: =>
    @trigger('stand',@)

  reveal: ->
    @at(0).flip()

  hitUntil17: ->
    while @score() < 17
      @hit()
    if @scores()[0] <= 21
      @trigger('stand',@)
