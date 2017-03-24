$(document).on('change', '.citySelect', function(){
  $(this).closest('form').trigger('submit');
});
