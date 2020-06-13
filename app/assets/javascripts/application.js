//
//= require jquery
//= require jquery-ujs
//= require bootstrap
//= require rails-ujs
//= require popper
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on("turbolinks:load", function() {
    setTimeout("$('.time-limit').fadeOut('slow')", 1500)
})