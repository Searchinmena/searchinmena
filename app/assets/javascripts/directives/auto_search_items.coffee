@Sim.directive 'autoSearch', ['$compile', '$timeout', 'AutoSuggest', '$state', '$document',  ($compile, $timeout, AutoSuggest, $state, $document) ->
  restrict: 'A'
  transclude: true
  scope:
    ngModel: '='
    control: '='
  link: (scope, elem, attrs) ->
    clickOnUl = false
    selected = null
    template = '<div class="dropdown"><ul class="dropdown-menu drop-down-list" style="display:block;" ng-hide="hideSuggestions ||  !filitered.length " ng-click="clickInside()" ><li ng-repeat="item in filitered = (items | filter:{name:ngModel} | limitTo:20) track by $index" ng-class="{active:$index==active}"  class="dropdown-submenu" ng-mouseenter= "mouseenter($index, item)" ><a ng-class="{rightarrow: item.categories[0]}" ng-click="onSelect(item.name)">{{item.name}}</a><ul class="dropdown-menu category-box" ng-if="item.categories[0]" ng-click="clickInside()"><h4>{{item.name}}</h4><li ng-repeat="catagory in item.categories | limitTo:20"><a class="category-btn" ng-click="onSelect(catagory.name)" href="javascript:void(0)" tabindex="-1">{{catagory.name}}</a></li></ul></li></ul></div>'

    elem.bind 'blur', ->
      $timeout (->
        if !clickOnUl
          scope.hideSuggestions = true
        else
          elem[0].focus();
      ), 250
      return

    scope.clickInside = () ->
      clickOnUl = true
      return

    elem.bind 'keydown', ($event) ->
      if $event.keyCode == 38 and scope.active > 0
        # arrow up
        scope.active--
        scope.$digest()
      else if $event.keyCode == 40 and scope.active < scope.filitered.length - 1
        # arrow down
        scope.active++
        scope.$digest()
      else if $event.keyCode == 13
        # enter
        scope.$apply ->
          scope.click scope.filitered[scope.active]
          return
      return

    scope.click = (item) ->
      scope.ngModel = item.name
      selected = item
      return

    scope.onSelect = (name) ->
      scope.search= {}
      scope.ngModel = name
      scope.control.query = name
      scope.search = scope.control;
      if scope.search.page then (scope.search.page = 1) else null
      $state.go("results", scope.search.toParams())
      return

    scope.control.searchItems = (type) ->
      scope.items = []
      if type == 'type'
        return
      else if !clickOnUl
        AutoSuggest.query({ type: scope.control.type, query: scope.control.query },
          (object) ->
            scope.items = object.items
            scope.hideSuggestions = false;
      )
      clickOnUl = false

    scope.mouseenter = ($index, item) ->
      scope.active = $index
      scope.categories = item.categories
      return

    scope.$watch 'ngModel', (input) ->
      if selected and selected.name == input
        return

      scope.active = -1
      scope.hideSuggestions = false
      return

    elem.after $compile(template)(scope)
    return
]
