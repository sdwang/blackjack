class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <input class="betAmount" placeholder="Place your bet!"></input><button class="bet-button">Bet</button>
    <div class="player-stack-container"></div>
    <div class="player-hand-container"></div>
    <div class="pot-stack-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="dealer-stack-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .bet-button': -> @bet()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-stack-container').html new ChipsView(collection: @model.get 'playerChips').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.pot-stack-container').html new ChipsView(collection: @model.get 'potChips').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.dealer-stack-container').html new ChipsView(collection: @model.get 'dealerChips').el

  bet: ->
    playerBet = Number($('.betAmount').val())
    @model.get('playerChips').remove(playerBet)
    @model.get('potChips').add(playerBet)
