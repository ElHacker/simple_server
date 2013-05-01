Block = Backbone.Model.extend(
  defaults: {
    "name" : ""
  }

  initialize: () ->
    @.createView()

  # initializes the corresponding view after the model
  createView: () ->
    blockView = new BlockView(el: $("##{@.get("name")}"), model:@)

  add_child: (child_block) ->
    unless @.get("children")?
      @.set("children", {})
    @.get("children")[child_block.cid] = child_block

  # Removes and returns a child from block
  # does a deep search
  remove_child: (child_id) ->
    children = @.get("children")
    removed_block = undefined
    if children?
      if children[child_id]?
        removed_block = children[child_id]
        delete children[child_id]
      else
        # search on all children
        for id, child_block of children
          removed_block = child_block.remove_child(child_id)
    return removed_block
)

window.Block = Block
