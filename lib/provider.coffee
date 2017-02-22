fs = require 'fs'
path = require 'path'

module.exports =
  selector: '.source.cpp, .source.h'
  suggestionPriority: 0
  filterSuggestions: true
  completions: {}

  loadCompletions: ->
    fs.readFile(
    #   path.resolve(__dirname, '..', 'completions.json'),
      path.resolve(__dirname, '..', 'completions_cpp.json'),
      (err, data) => @completions = JSON.parse(data) unless err?)

  getSuggestions: ({editor, prefix}) ->
    # if prefix.length < 3 or not editor.getText().match(/\bcc\b/)
    #   return []
    return [] if prefix.length < 3

    completions = []
    for type, names of @completions
      for name in names
        completions.push({type: type, text: name})
    completions
