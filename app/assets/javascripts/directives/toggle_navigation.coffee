@Sim.directive 'toggleNav', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      $("nav").toggleClass "open"

@Sim.directive 'toggleCategories', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      $(".all-categories-list").toggleClass "show"

@Sim.directive 'toggleDashboardNav', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      $(".dashboard-navigation").toggleClass "show"