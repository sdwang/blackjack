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
    @get('dealerChips').addChips(Math.floor(Math.random() * 100) + 100)
    @set 'potChips', new Chips([], 'pot')
    @listenToStand()

  newGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @listenToStand()



  listenToStand: ->
    @get('playerHand').on('stand', =>
      @get('dealerHand').reveal()
      @get('dealerHand').hitUntil17()
      if @get('playerHand').score() > @get('dealerHand').score()
        @get('playerChips').addChips(@get('potChips').count())
        @get('potChips').removeChips(@get('potChips').count())
        alert 'Player Wins!'
        @trigger('newGameTrigger')
      else if @get('playerHand').score() == @get('dealerHand').score()
        alert 'Tie Game!'
        @trigger('newGameTrigger')
      else
        @get('dealerChips').addChips(@get('potChips').count())
        @get('potChips').removeChips(@get('potChips').count())
        alert 'Dealer Wins!'
        @trigger('newGameTrigger')
    )