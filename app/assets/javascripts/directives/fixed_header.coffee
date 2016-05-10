@Sim.directive 'fixedHeader', ['$window','MAX_FIX_HEADER_SCREEN_SIZE', ($window,MAX_FIX_HEADER_SCREEN_SIZE) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    angular.element($window).bind 'scroll', ->

      unless $window.fixmeTop
        $window.fixmeTop = $('.sticky').offset().top

      currentScroll = $(window).scrollTop()

      if currentScroll >= fixmeTop && $(window).width() > MAX_FIX_HEADER_SCREEN_SIZE
        $('.sticky').addClass('fixed_header_on_top')
        $('.list-container').removeClass('mar-top-0')
        $('.list-container').css('margin-top', $('.sticky').height())
      else
        $('.sticky').removeClass('fixed_header_on_top')      
        $('.list-container').addClass('mar-top-0')

]
  