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
)

window.BlockView = BlockView
