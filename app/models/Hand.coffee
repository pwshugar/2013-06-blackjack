class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    console.log(@scores()[0])
    if @scores()[0] > 21 then @bust()
  bust: ->
    @trigger 'bust'
    console.log('bust')
    @trigger 'resetMe'
  reveal: ->
    @each (card) ->
      card.set('revealed', true)
  add17: ->
    while @scores()[0] < 17
      @hit()
    if @scores()[0] < 22 then @trigger('compare')
  stand: ->
    @trigger 'stand'
  checkNumber: ->


  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  # add17: ->
  #   if @scores().length == 2
  #     while @scores()[0] < 17 and @scores()[1] < 17
  #       @hit()
