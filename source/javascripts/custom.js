$(function(){
  $('[rel="tooltip"]').tooltip();

  if ( window.location.pathname == '/' ) {
    $('[rel="tooltip"]').hover(
      function () {
        $('.tooltip.top').addClass("home");
      }
    );
  }

});
