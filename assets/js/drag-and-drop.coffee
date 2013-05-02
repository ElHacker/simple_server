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



  generateCode = (block) ->
    children_code = ""
    if block.get("children")?
      for key, child_block of block.get("children")
        children_code += generateCode(child_block)
    generated_code = block.get("code")(children_code, block.get("params"))
    return generated_code


  $("#run").on('click', (event) ->
    final_code = ""
    for key, child_block of root_block.children
      final_code += generateCode(child_block)
    console.log final_code
    # Send generated code to server to be compiled and executed
    $.post('/run', {code:final_code}, (data, textStatus, jqXHR) ->
      $("#output-message").html(data.code)
    ).fail( (error) ->
      $("#output-message").html(error)
    )
  )

  # Start the basic blocks
  for_block = new Block( 
     name:"for"
     code: (child_block, params) ->
        return "for(#{params}) { #{child_block} }"
  )
  if_block = new Block( 
    name:"if"
    code: (child_block, params) ->
      return "if (#{params}) { #{child_block} }"
  )
  else_block = new Block( 
    name:"else"
    code: (child_block, params="") ->
      return "else { #{child_block}  }"
  )
  main_block = new Block( 
    name:"main"
    code: (child_block, params="") ->
      return "main(#{params}) { #{child_block} }"
  )
  function_block = new Block(
    name:"function"
    code: (child_block, params="") ->
      return "function #{params} { #{child_block}  }"
  )
  statement_block = new Block(
    name:"statement"
    code: (child_block, params) ->
      return "#{params}"
  )

  # Remove statement droppable block
  # TODO: REFACTOR!!!!!
  $("#statement .droppable").remove()

