
$(document).ready(function() {
return $(".readMore").toggle((function() {
$(".description").animate({
height: "100%"
}, 800);
return $(".readMore").text("Hide description");
}), function() {
$(".description").animate({
height: "94px"
}, 800);
return $(".readMore").text("Read More");
});
});
