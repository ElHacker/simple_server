module.exports =
  index : (req, res) ->
    res.render "index",
      title: "Express"

  run: (req, res) ->
    code = req.body.code
    console.log code
    res.send(200, {code})
