class Block
  @next_id: 0

  constructor: (@name) ->
    @children = {}
    @id = Block.next_id
    Block.next_id += 1

  add_child: (child_block) ->
    @children[child_block.id] = child_block

  # Removes and returns a child from block
  # does a deep search
  remove_child: (child_id) ->
    removed_block = undefined
    if @children[child_id]?
      removed_block = @children[child_id]
      delete @children[child_id]
    else
      # search on all children
      for id, child_block of @children
        removed_block = child_block.remove_child(child_id)
    return removed_block

window.Block = Block
