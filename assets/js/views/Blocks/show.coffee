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
    $dragged = $(ui.draggable)
    $droppable.removeClass "ui-state-highlight"
    $droppable.parentsUntil("#droppable-space").css height: "auto"
    $droppable.css
      width: "auto"
      "min-height": "117px"
      height: "auto"
    $dragged.appendTo $droppable

  onOver : (event, ui) ->
    $(this).addClass "ui-state-highlight"

  onOut : (event, ui) ->
    $(this).removeClass "ui-state-highlight"
)

window.BlockView = BlockView
