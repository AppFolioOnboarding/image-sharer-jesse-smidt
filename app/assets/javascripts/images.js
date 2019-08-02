$(function(){
  $('form.image-delete-form').submit(function() {
    return confirm("Are you sure you want to delete this image?");
  });

  $('[data-toggle="tooltip"]').tooltip()
});

