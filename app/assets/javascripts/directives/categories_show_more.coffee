@Sim.directive 'showMore', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', -> 
      $("#list-"+ attrs['showMore']).css("height", "100%");
      $("#show-more-"+ attrs['showMore']).addClass("hide");

@Sim.directive 'showLess', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      $("#list-"+ attrs['showLess']).css("height", "250px");
      $("#show-more-"+ attrs['showLess']).removeClass("hide");
 

@Sim.directive 'scrollTo', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      if $(window).width() > 1100
        height =  $('.sticky').height()
      else
        height = 0
      $('html, body').animate { scrollTop: $('#'+ attrs['scrollTo']).offset().top - height - 20}, 500