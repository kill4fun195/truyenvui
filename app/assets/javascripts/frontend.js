$(document).ready(function(){  
  $(".main-content").each(function(index, item) {
    var height = $(item).find(".col-sm-7 ").outerHeight();
    $(item).find(".col-sm-5").height(height);
  });
  var content_height = $(".row.content").outerHeight();
  $(".row.content").find(".sidenav").height(content_height);

  $(".sticky_column").stick_in_parent();
})
