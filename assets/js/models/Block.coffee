Block = Backbone.Model.extend(
  defaults: {
    "name" : ""
    "children": {}
  }

  initialize: () ->
    new BlockView(el: $("##{@.get("name")}"), model:@)

  add_child: (child_block) ->
    children = @.get("children")
    children[child_block.cid] = child_block
    @.set("children", children)

  # Removes and returns a child from block
  # does a deep search
  remove_child: (child_id) ->
    children = @.get("children")
    removed_block = undefined
    if children[child_id]?
      removed_block = children[child_id]
      delete children[child_id]
    else
      # search on all children
      for id, child_block of children
        removed_block = child_block.remove_child(child_id)
    @.set("children", children)
    return removed_block
)

window.Block = Block
