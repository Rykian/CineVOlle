// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  function handleSubmit(event) {
    event.preventDefault();

    $.post(event.target.action,
           $(event.target).serialize(),
           function(data) { console.log(data) },
           'json')
  }

  $('form').on('submit', handleSubmit )
})
