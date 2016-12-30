$(document).ready(function(){  
 $(".publish-time").each(function(){
  $(this).html($(this).text().replace("minutes", "phút").replace("about", "khoảng").replace("hours", "giờ").replace("days", "ngày").replace("less than a minute","khoảng 1 phút").replace("minute","phút").replace("hour","giờ").replace("day", "ngày"));
 });
});
    
