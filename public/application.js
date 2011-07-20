$().ready( function(){
  var inputTimer;
  $("input#time").keyup(function() {
    clearTimeout(inputTimer);
    inputTimer = setTimeout(ajaxSearch, 600);
  });

  function ajaxSearch() {
    $.post("/convert.json", {"time":$("input#time").val()}, function(data){
      $(".stamp").text(data.stamp);
    });
  }
  $(".example a").click( function(ev){
    ev.preventDefault();
    $("input#time").val($(this).text());
    ajaxSearch();
  });
});