# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('#slider').slider
    range: true
    min: 0
    max: 300
    values: [
      5
      280
    ]
    slide: (event, ui) ->
      $('#minprice').val ui.values[0]
      $('#maxprice').val ui.values[1]
      return
  $('#minprice').val '' + $('#slider').slider('values', 0)
  $('#maxprice').val '' + $('#slider').slider('values', 1)
  return
