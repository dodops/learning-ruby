modulejs.define('ui/contributors', function(){
  return $.ajax({
    method: "GET",
    url: "https://api.github.com/repos/learning-ruby/brasil-sem-zika/contributors",
    dataType: 'json'
   })
     .done(function(contri) {
        $.each(contri, function (index, value) {
          $("#contributors").append("<a href='"+ value.html_url +"'><img src='" + value.avatar_url + "' title='"+ value.login +"' style='border-radius: 20px; width:100px; padding-bottom: 10px; margin-left: 10px;'> </a>");
    });
  });
});
