// READ MORE TOGGLE

// *********
// yo Eph - please comment on what this is actually toggling, and i'll convert to coffee
// dr. J

$(document).ready(function() {
  $('.readMore').toggle(function() {
    $('.description').animate({height:'100%'}, 800);
    $('.readMore').text("Hide description");
  }, function(){
    $('.description').animate({height:'94px'}, 800);
    $('.readMore').text("Read More");
  });
});
