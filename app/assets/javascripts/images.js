$(function(){
  $('form.edit_image').submit(function() {
    return confirm("Are you sure you want to delete this image?");
  });
});

