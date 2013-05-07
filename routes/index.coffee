spawn = require('child_process').spawn
vm = require('../libs/simple/src/vm.coffee')

module.exports =
  index : (req, res) ->
    res.render "index",
      title: "Express"

  run: (req, res) ->
    code = req.body.code
    console.log code
    stdout = ""
    stderr = ""

    console.log process.cwd()
    simple_parser = spawn("ruby",["#{process.cwd()}/libs/simple/src/SimpleParser.rb"])

    simple_parser.stdout.on('data', (data) ->
        console.log "Stdout: #{data}"
        stdout += data
    )

    simple_parser.stderr.on('data', (data) ->
        console.log "Stderr: #{data}"
        stderr += data
    )

    simple_parser.on('close', (exit_code)->
      console.log "child process exited with code #{exit_code}"
      if stderr != ""
        res.send(200, stderr)
      else
        results = vm.node(stdout)
        console.log vm
        res.send(200, {results})
    )

    simple_parser.stdin.setEncoding("utf8")
    simple_parser.stdin.write("#{code}\n")
    simple_parser.stdin.end()
