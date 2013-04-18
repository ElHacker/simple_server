$ ->
  onDrop = (event, ui) ->
    $droppable = $(this)
    $dragged = $(ui.draggable)
    $droppable.removeClass "ui-state-highlight"
    $droppable.animate height: "auto"
    $dragged.appendTo($droppable).animate width: "auto"

  onOver = (event, ui) ->
    $(this).addClass "ui-state-highlight"

  onOut = (event, ui) ->
    $(this).removeClass "ui-state-highlight"

  $droppableSpace = $("#droppable-space")
  $draggableBlocks = $("#draggable-blocks")

  $(".draggable").draggable
    cursor: "move"
    revert: "invalid"
    helper: "clone"
    containment: "document"

  $(".droppable").droppable
    greedy: true
    drop: (event, ui) ->
      $droppable = $(this)
      $dragged = $(ui.draggable)
      $droppable.removeClass "ui-state-highlight"
      $droppable.parentsUntil("#droppable-space").css height: "auto"
      $droppable.css
        width: "auto"
        "min-height": "117px"
        height: "auto"
      $dragged.appendTo $droppable
    over: onOver
    out: onOut

  $droppableSpace.droppable
    drop: onDrop
    over: onOver
    out: onOut
