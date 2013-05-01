$ ->
  
  root_block = 
    name: "root"
    children: {}

  onDrop = (event, ui) ->
    $droppable = $(this)
    $dragged = $(ui.draggable)
    $droppable.removeClass "ui-state-highlight"
    $droppable.animate height: "auto"
    $dragged.appendTo($droppable).animate width: "auto"
    childBlock = $dragged.data("backbone-view").model
    root_block.children[childBlock.cid] = childBlock
    console.log "ROOT:"
    console.log JSON.stringify(root_block, null, 2)

  onOver = (event, ui) ->
    $(this).addClass "ui-state-highlight"

  onOut = (event, ui) ->
    $dragged = $(ui.draggable)
    childBlock = $dragged.data("backbone-view").model
    $(this).removeClass "ui-state-highlight"
    if root_block.children[childBlock.cid]
      delete root_block.children[childBlock.cid]

  $droppableSpace = $("#droppable-space")
  $draggableBlocks = $("#draggable-blocks")

  $droppableSpace.droppable
    drop: onDrop
    over: onOver
    out: onOut

  # Start the basic blocks
  for_block = new Block({name:"for"})
  if_block = new Block({name:"if"})
  else_block = new Block({name:"else"})

