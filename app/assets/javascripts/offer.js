$().ready(function(){
  $('#link_get_form').bind('click', function() {
    if ($('#get_form').is(':visible')) {
      $('#get_form').hide('slow')
      $('#link_get_form').html('Show the request form')
    }
    else {
      $('#get_form').show('slow')
      $('#link_get_form').html('Hide the request form')
    }
  });
});