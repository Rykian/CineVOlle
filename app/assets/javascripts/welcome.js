// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  var subscribe = function() {
    function displayResult(data) {
      var name = Object.keys(data)[0];
      var message = data[name];
      if(name == 'error') {
        name = 'danger';
      }

      var alert = $('<div class="alert alert-' + name + ' alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + message + '</div>');

      $('#header').after(alert.hide());
      alert.slideDown();
    }

    function handleSubmit(event) {
      event.preventDefault();
      $.post(event.target.action,
             $(event.target).serialize(),
             displayResult,
             'json')
    }
    $('form.xhr-enabled').on('submit', handleSubmit);
  }
  subscribe();

  var manageTabs = function() {
    $('.movie-list').hide();
    $('.movie-list').first().show();

    var handleSelect = function() {
      event.preventDefault();
      $('.movie-list').hide();
      var target = event.currentTarget.dataset["week"];
      var tabgroup = $(event.currentTarget).closest('div');
      tabgroup.find('#' + target).show();

      tabgroup.find('.nav li').removeClass('active');
      $(event.currentTarget).closest('li').addClass('active');
    }
    $('.nav.nav-tabs a').on('click', handleSelect);
  }
  manageTabs();
})
