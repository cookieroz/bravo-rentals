# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("li.zebra:even").addClass "zebra-even"
  $("div.zebra-index:even").addClass "zebra-even"