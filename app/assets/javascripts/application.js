// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.ru.js
//= require_tree .
//

$(function() {
  $("#notify-container").click(function() {
    $(this).fadeOut("slow");
  });

  $("[data-behavior~='datepicker']").datepicker({
    "autoclose": true,
    "format": "dd.mm.yyyy",
    "weekStart": 1,
    "language": "ru"
  })

  $('.has-tooltip').tooltip();
});
