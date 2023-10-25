$("ul.nav>li>a").click(function () {
  $("ul.nav>li.active").removeClass("active");
  $("ul.nav>li>a.active").not(this).parent().removeClass("active");
  $(this).parent().toggleClass("active");
});

$("ul.nav>li>a").click(function(){
  Shiny.onInputChange("tabSelection", $(this).attr('href'));
});