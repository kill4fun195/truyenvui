#= require active_admin/base
$(document).ready(function(){  
 $(".table_actions button").on("click",function(){
    $(this).parent(".table_actions").find("button").removeClass("selected");
    post_id = $(this).parent(".table_actions").find(".post_id").text();
    status = $(this).text().toString();
    url = "/admin/posts/update_status?post_id="+post_id+"&status="+status;
    $.post(url);
    $(this).addClass("selected");
 });
});

