(function(){var a,b,c,d,e,f,g,h,i,j,k,l;c=!1,b=!0,d=600,$.srSmoothscroll({step:100,speed:100,ease:"swing",target:$("body"),container:$(window)}),smoothScroll.init({updateURL:!1,offset:20}),l=function(){var a,b,e;return e=$(document).scrollTop(),$("#main-image").css("top",e/3),$("#main-image h1").css("padding-top",(c?60:200)+e/5),$("#sub-header").css("top",e/2),e>d?(b=0,a=1):(b=c?-50:-70,a=0),$(".top-nav.sticky").css({top:b,opacity:a}),$(".top-nav-mobile").css({top:b,opacity:a})},$(document).scroll(function(){return l()}),$(window).bind("hashchange",function(){return e()}),i=function(){var a,b;return b=250,a=mina.easeinout,$(".project").each(function(c,d){var e,f,g;return d=$(d),g=Snap(d.find("svg")[0]),(e=g.select("path"))?(f={from:e.attr("d"),to:d.attr("data-path-hover")},d.on("mouseenter",function(){return e.animate({path:f.to},b,a)}),d.on("mouseleave",function(){return e.animate({path:f.from},b,a)})):void 0})},h=function(){var a,b,c,d,e,f;return f=500,a=mina.easeinout,b=$(".top-nav-mobile"),e=Snap(b.find("svg")[0]),(c=e.select("path"))?(d={from:c.attr("d"),to:b.attr("data-path-click")},b.click(function(){var e,g;return e=b.hasClass("open"),g=e?d.from:d.to,e?(b.find(".inner").removeClass("open"),b.animate({"background-color":"rgba(255, 255, 255, 0)"},f),c.animate({path:g},f,a,function(){return b.removeClass("open"),b.find("ul").hide(),b.find("svg").hide()})):(b.find("svg").show(),b.find("ul").show(),b.find(".inner").addClass("open"),b.addClass("open"),b.animate({"background-color":"rgba(255, 255, 255, 0.8)"},f),c.animate({path:g},f,a))})):void 0},k=function(){return g(),$("#main-image").removeClass("home-image").addClass("project-image"),$(".nav-element a").removeClass("active"),$(".project-specific").show(),$(".home-specific").hide(),$(document).scrollTop(0)},j=function(){return g(!0),$("#main-image").removeClass("project-image").addClass("home-image"),$(".nav-element a").removeClass("active"),$(".about-link").addClass("active"),$(".home-specific").show(),$(".project-specific").hide(),$(document).scrollTop(0)},e=function(){return"#project"===location.hash?(b=!1,k()):(b=!0,j())},a=function(){return c=$(window).width()<=768},f=function(){var a;return a=500,$("#footerImage").click(function(){return $("#cardSection").fadeIn().css("display","flex")}),$("#cardSection .close").click(function(){return $("#cardSection").fadeOut()}),$("#card3dBtn").click(function(){var b;return $("#card3dBtn").toggleClass("active"),$("#cardSection .card").toggleClass("built"),b=$("#cardSection .shadow"),b.is(":visible")?b.fadeOut(a):b.fadeIn(a)})},g=function(){var a,c;return c=$(window).height(),a=400,b&&(a=c>600?600:c),$("#main-image").height(a),d=a},$(window).resize(function(){return a(),l(),g()}),$(document).ready(function(){return e(),i(),h(),a(),f()})}).call(this);