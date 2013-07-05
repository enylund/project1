# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('#channel_user_tokens').tokenInput '/users/index.json',
    theme: 'facebook',
    propertyToSearch: "username",
    prePopulate: $('#channel_user_tokens').data('load'),
    resultsFormatter: (item) ->
      return "<li>" + item.username + "</li>"
    tokenFormatter: (item) ->
      return "<li>" + item.username + "</li>"

$(document).ready(ready)
$(document).on('page:load', ready)
