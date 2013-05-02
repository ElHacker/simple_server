BlockView = Backbone.View.extend(

  initialize: () ->
    @render()

  render: () ->
    # Pass variables in using Underscore.js Template
    variables = { block_name: this.model.get("name")  }
    # Compile template using underscore
    template = _.template( $("#block_template").html(), variables )
    # Load the compiled HTML into the Backbone "el"
    this.$el.html( template  )
    # Bind a focus event on text input
    # TODO: change it to be bound by the backbone view's events
    bound_model = @.model
    this.$(".code-block-params").on('blur', (event) ->
      params = $(@).val()
      bound_model.set("params", params )
    )
    # Bind a reference to the view
    this.$(".draggable").data("backbone-view", this)
    # Load the jquery ui draggable widget
    this.$(".draggable").draggable
      cursor: "move"
      revert: "invalid"
      helper: "clone"
      containment: "document"
      stop: () ->
        originalBlock = $(@).data("backbone-view").model
        cloneBlock = new Block(
          name: originalBlock.get("name")
          code: originalBlock.get("code") 
        )
        # Remove statement droppable block
        # TODO: REFACTOR!!!!!
        $("#statement .droppable").remove()
    # Load the jquery ui droppable widget
    this.$(".droppable").droppable
      greedy: true
      tolerance: 'pointer'
      drop: @onDrop
      over: @onOver
      out: @onOut

  onDrop: (event, ui) ->
    $droppable = $(this)
    parentBlock = $droppable.parent().data("backbone-view").model
    $dragged = $(ui.draggable)
    childBlock = $dragged.data("backbone-view").model
    $droppable.removeClass "ui-state-highlight"
    $droppable.parentsUntil("#droppable-space").css height: "auto"
    $droppable.css
      width: "auto"
      "min-height": "117px"
      height: "auto"
    #$dragged.appendTo $droppable
    parentBlock.add_child childBlock
    $droppable.append $dragged

  onOver : (event, ui) ->
    $(this).addClass "ui-state-highlight"

  onOut : (event, ui) ->
    $droppable = $(this)
    $dragged = $(ui.draggable)
    $droppable.removeClass "ui-state-highlight"
    parentBlock = $droppable.parent().data("backbone-view").model
    childBlock = $dragged.data("backbone-view").model
    parentBlock.remove_child childBlock.cid
)

window.BlockView = BlockView
