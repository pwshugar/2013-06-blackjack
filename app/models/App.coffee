class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', =>
      if @checknumber(@get('playerHand').scores()) == 21 and @get('playerHand').models.length == 2
        @get('dealerHand').reveal(); @get('dealerHand').compare()
      else @get('dealerHand').reveal(); @get('dealerHand').add17()
    @get('playerHand').on 'bust', => alert 'You Bust!'
    @get('dealerHand').on 'bust', => alert 'Dealer Busts!'
    @get('dealerHand').on 'compare', =>
      dScore = @checknumber(@get('dealerHand').scores())
      pScore = @checknumber(@get('playerHand').scores())
      if pScore == 21 and @get('playerHand').models.length == 2
        if pScore > dScore or pScore == dScore and @get('dealerHand').models.length != 2
          alert 'Blackjack!! You Win!'
      else if dScore == 21 and @get('dealerHand').models.length == 2
        if dScore > pScore or dScore == pScore and @get('playerHand').models.length != 2
          alert 'Blackjack!! Dealer Wins!'
      else if dScore == pScore then alert 'Push'
      else if dScore > pScore then alert 'Dealer Wins!'
      else if pScore > dScore then alert 'You Win!'
      @initialize(); @trigger 'resetDeck'
    @get('playerHand').on 'resetMe', => @initialize(); @trigger 'resetDeck'
    @get('dealerHand').on 'resetMe', => @initialize(); @trigger 'resetDeck'

  checknumber: (scores)-> if scores[1] < 22 then scores[1] else scores[0]

