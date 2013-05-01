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
    # Bind a reference to the view
    this.$(".draggable").data("backbone-view", this)
    # Load the jquery ui draggable widget
    this.$(".draggable").draggable
      cursor: "move"
      revert: "invalid"
      helper: "clone"
      containment: "document"
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
    console.log JSON.stringify(parentBlock, null, 2)

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
