$(document).ready(function() {
  var totalWidth;
  totalWidth = 0;
  $("#thumbs, .items").children().each(function() {
    return totalWidth = totalWidth + $(this).outerWidth(true);
  });
  return $("#thumbs, .items").css("width", parseInt(totalWidth) + "px");
});