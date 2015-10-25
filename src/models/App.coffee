# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->

    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerChips', new Chips([], 'player')
    @get('playerChips').addChips(stack)
    @set 'dealerChips', new Chips([], 'dealer')
    @get('dealerChips').addChips(Math.floor(Math.random() * 200) + 300)
    @set 'potChips', new Chips([], 'pot')
    @listenToHand()

  newGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @listenToHand()



  listenToHand: ->
    @get('playerHand').on('bust', =>
      alert 'Dealers Wins!'
      @get('dealerChips').addChips(@get('potChips').count())
      @get('potChips').addChips(@get('potChips').count())
      setTimeout(@trigger('newGameTrigger'), 2000)
    )


    @get('playerHand').on('stand', =>
      @get('dealerHand').on('bust', =>
        alert 'Player Wins!'
        @get('playerChips').addChips(@get('potChips').count())
        @get('potChips').removeChips(@get('potChips').count())
        setTimeout(@trigger('newGameTrigger'), 2000)
      )
      @get('dealerHand').reveal()
      @get('dealerHand').hitUntil17()
    )

    @get('dealerHand').on('stand', =>
      if @get('playerHand').score() > @get('dealerHand').score()
        alert 'Player Wins!'
        @get('playerChips').addChips(@get('potChips').count())
        @get('potChips').removeChips(@get('potChips').count())
        setTimeout(@trigger('newGameTrigger'), 2000)
      else if @get('playerHand').score() == @get('dealerHand').score()
        alert 'Tie Game!'
        setTimeout(@trigger('newGameTrigger'), 2000)
      else
        alert 'Dealer Wins!'
        @get('dealerChips').addChips(@get('potChips').count())
        @get('potChips').removeChips(@get('potChips').count())
        setTimeout(@trigger('newGameTrigger'), 2000)
    )