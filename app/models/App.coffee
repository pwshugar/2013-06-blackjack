class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', =>
      @get('dealerHand').reveal()
      @get('dealerHand').add17()
    @get('playerHand').on 'bust', =>
      alert 'Player Busts!'
    @get('dealerHand').on 'bust', =>
      alert 'Dealer Busts!'
    @get('dealerHand').on 'compare', =>
      if @checknumber(@get('dealerHand').scores()) > @checknumber(@get('playerHand').scores())
        alert 'Dealer Wins'
      else alert 'Player Wins'
      @initialize()
      @trigger 'resetDeck'
    @get('playerHand').on 'resetMe', =>
      @initialize()
      @trigger 'resetDeck'
    @get('dealerHand').on 'resetMe', =>
      @initialize()
      @trigger 'resetDeck'

  checknumber: (scores)->
    if scores[1] < 22
      return scores[1]
    else
      return scores[0]

