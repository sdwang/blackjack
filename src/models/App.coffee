# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on('stand', =>
      console.log('app detects player stand')
      console.dir(@get('dealerHand'))
      @get('dealerHand').reveal()
      #compare playerhand and dealerhand
      if @get('playerHand').score() > @get('dealerHand').score()
        #alert winner
        alert 'Player Wins!'
      else
        alert 'Dealer Wins!'
    )