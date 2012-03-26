// Toggle Menu

$(document).ready(function() {



  $("#content-left ul > li > a").click(function(){
    $(this).next().slideToggle("medium");
  });




  // // Slide
  // $("#content-left ul > li > a.expanded + ul").slideToggle("medium");
  // $("#content-left ul > li > a").click(function() {
  //   $(this).toggleClass("expanded").toggleClass("collapsed").find("+ ul").slideToggle("medium");
  // });





});
