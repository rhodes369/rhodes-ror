// READ MORE TOGGLE

$(document).ready(function() {
  $('.readMore').toggle(function() {
    $('.description').animate({height:'100%'}, 800);
    $('.readMore').text("Hide description");
  }, function(){
    $('.description').animate({height:'94px'}, 800);
    $('.readMore').text("Read More");
  });
});
