$(document).ready(function() {
$("#content-left ul > li > a.expanded + ul").slideToggle("medium");
return $("#content-left ul > li > a").click(function() {
return $(this).toggleClass("expanded").toggleClass("collapsed").find("+ ul").slideToggle("medium");
});
}); 