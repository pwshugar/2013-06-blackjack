class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change render', => @render()
    @render()

  render: ->
    # console.log('renderView!')
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    if @collection.scores().length == 2
      if @collection.scores()[1] < 22
        @$('.score').text @collection.scores()[1]
      else
        @$('.score').text @collection.scores()[0]
    else
      @$('.score').text @collection.scores()[0]
