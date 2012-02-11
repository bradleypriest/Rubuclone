$().ready( function(){
  var inputTimer;
  $("input, textarea").keyup(function() {
    clearTimeout(inputTimer);
    inputTimer = setTimeout(ajaxSearch, 600);
  });

  function ajaxSearch() {
    $.post("/convert.json", {"string":$("textarea#string").val(),"regex":$("input#regex").val()}, function(data){
      $("#result").html(data.result);
    });
  }
});