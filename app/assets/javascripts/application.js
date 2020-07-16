// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery

//= require jquery_ujs
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require datatables.min.js
//= require activestorage
//= require turbolinks
//= require popper
//= require bootstrap-sprockets
//= require movies
//= require_tree .


document.addEventListener("turbolinks:load", function() {
  $("body").on("change", ".ajax-input", function() {
    Rails.fire(this.form, "submit");
  });

  return $("input[data-autocomplete]").each(function() {
    var url;
    url = $(this).data('autocomplete');
    return $(this).autocomplete({
      source: url
    });
  });


});


