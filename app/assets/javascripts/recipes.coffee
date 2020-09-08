# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  el = document.getElementById("sortable_cooking")
  if el != null
    sortable = Sortable.create(el,
    delay: 100
    handle: "#handle"
    animation: 300
    onUpdate: (evt) ->
        $.ajax
          url: '/recipe' + '/' + $("#recipe_id").val() + '/sort_cooking'
          type: 'patch'
          data: { from: evt.oldIndex, to: evt.newIndex }
    )

  el = document.getElementById("sortable_ingredient")
  if el != null
    sortable = Sortable.create(el,
    delay: 100
    handle: "#handle"
    animation: 300
    onUpdate: (evt) ->
        $.ajax
          url: '/recipe' + '/' + $("#recipe_id").val() + '/sort_ingredient'
          type: 'patch'
          data: { from: evt.oldIndex, to: evt.newIndex }
    )