@Sim.directive 'showMore', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', -> 
      $("#list-"+ attrs['showMore']).addClass("list-max-height");
      $("#show-more-"+ attrs['showMore']).addClass("hide");

@Sim.directive 'showLess', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      $("#list-"+ attrs['showLess']).addClass("list-min-height");
      $("#show-more-"+ attrs['showLess']).removeClass("hide");
 

@Sim.directive 'scrollTo', ['MAX_FIX_HEADER_SCREEN_SIZE', (MAX_FIX_HEADER_SCREEN_SIZE) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      if $(window).width() > MAX_FIX_HEADER_SCREEN_SIZE
        height =  $('.sticky').height()
      else
        height = 0
      $('html, body').animate { scrollTop: $('#'+ attrs['scrollTo']).offset().top - height - 20}, 500
]