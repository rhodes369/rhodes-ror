# READ MORE TOGGLE

$(document).ready ->

  # On .readMore click, expand height of .description to 100% and change text to "Hide description".
  # On click again, change height back to 94px and text back to "read more".

  $(".readMore").toggle (->
    $(".description").animate
      height: "100%"
    , 800
    $(".readMore").text "Hide description"
  ), ->
    $(".description").animate
      height: "94px"
    , 800
    $(".readMore").text "Read More"
