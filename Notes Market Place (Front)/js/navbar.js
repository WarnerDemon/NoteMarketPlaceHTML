$(function () {

    showHideNav()
  
    $(window).scroll(function(){
  
        showHideNav()
  
    });
  
    function showHideNav() {
  
        if($(window).scrollTop() > 100){
  
            $("nav").removeClass("navbar-dark");
            $("nav").removeClass("bg-transparent");
            $("nav").addClass("navbar-light");
            $("nav").addClass("bg-light");
            $("nav").addClass("nav-border");

            $("ul button").removeClass("homepage-navbar-logout-button");
            $("ul button").addClass("navbar-button");

            $(".navbar-brand img").attr("src", "images/User-Profile/logo.png");
  
        }
        else {
  
            $("nav").removeClass("navbar-light");
            $("nav").removeClass("bg-light");
            $("nav").removeClass("nav-border");
            $("nav").addClass("navbar-dark");
            $("nav").addClass("bg-transparent");

            $("ul button").removeClass("navbar-button");
            $("ul button").addClass("homepage-navbar-logout-button");

            $(".navbar-brand img").attr("src", "images/pre-login/top-logo.png");
  
        }
  
    }
  
  });