@Sim.directive 'fixedHeader', ['$window', ($window) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    angular.element($window).bind 'scroll', ->

      unless $window.fixmeTop
        $window.fixmeTop = $('.sticky').offset().top

      currentScroll = $(window).scrollTop()

      if currentScroll >= fixmeTop && $(window).width() > 1100
        $('.sticky').addClass('fixed_header_on_top')
        $('.list-container').css('margin-top', $('.sticky').height())
      else
        $('.sticky').removeClass('fixed_header_on_top')      
        $('.list-container').css('margin-top', 0)

]
  