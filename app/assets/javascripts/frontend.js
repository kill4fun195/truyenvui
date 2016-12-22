$(document).ready(function(){  
  $(".main-content").each(function(index, item) {
    var height = $(item).find(".col-sm-7 ").outerHeight();
    $(item).find(".col-sm-5").height(height);
  });
  $("#content .sidenav").height($("#content").height());

  $(".sticky_column").stick_in_parent();
  $(".fb-like-button").on("click",function(){
    $(this).find(".before-click").toggle();
    $(this).find(".after-click").toggle();
  });
})
