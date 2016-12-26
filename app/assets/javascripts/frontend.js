$(document).ready(function(){  
  $(".main-content").each(function(index, item) {
    var height = $(item).find(".col-sm-7").height();
    $(item).find(".col-sm-5").height(height);
  });
  $("#content .sidenav").height($("#content").height());
  $(".sticky_column").stick_in_parent();
  // like 
  $(".fb-like-button").on("click",function(){
    _this = $(this);
    var id = _this.find(".post-id").html();
    if (_this.find(".before-click").is(":visible") == true )
    { 
      var url = "/posts/update_like/?post_id=" + id + "&check=asc" ;
    }
    else
    {
      var url = "/posts/update_like/?post_id=" + id + "&check=desc" ;
    }
    $.get(url);
    $(this).find(".before-click").toggle();
    $(this).find(".after-click").toggle();
  });
  // pagging
  $(".infinite-scrolling .btn").click(function(){
    var url = $(this).parent(".infinite-scrolling").find(".pagination .next_page").attr("href");
    if(typeof(url) != "undefined")
    {
      window.location.href = $(this).parent(".infinite-scrolling").find(".pagination .next_page").attr("href");
    }
    else 
    {
      window.location.href = "http://localhost:3000/het";
    }
  });
  // update comment
  function getFacebookCommentCount(url, callback) {
    $.getJSON('https://graph.facebook.com/?ids='+url, function(data) {
        if(url && url != '#' && url != '') {
           if(!data['error']) {
              callback(data[url]['share']['comment_count']);
           }
        }
     });
  }
  var current_url = window.location;
  var string = window.location.toString();
  var substring = "http://localhost:3000/posts/";
  if(string.includes(substring))
  {
     if($("#post-show").is(":visible") == true)
    {
      var post_id = $("#post-show .post-id").html().toString().replace(/\n|\r/g, "");
      getFacebookCommentCount("http://xem.vn/photo/807831", function(comment_count) {
      $.ajax({  
        url: "/posts/update_comment",
        type: "GET",
        data: {"post": {
            post_id,comment_count
          }
        },
        success: function(response) {
         
        }
        });
      });
    } 
  }

});
