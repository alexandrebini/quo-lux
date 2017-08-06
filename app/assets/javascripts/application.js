//= require rails-ujs
//= require jquery
//= require turbolinks
//= require materialize-sprockets
//= require materialize-form
//= require_tree .

$(document).on('turbolinks:load', function() {
  window.materializeForm.init()
})
