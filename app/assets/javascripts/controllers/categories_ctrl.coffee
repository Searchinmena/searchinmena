@Sim.controller 'CategoriesCtrl', ['$scope' ,'$http','$anchorScroll','$location', 'language','$stateParams',
($scope,$http,$anchorScroll,$location,language,$stateParams) ->
    
  if $stateParams.type == 'product'
    CATEGORIES_PATH = "/product_categories"
    $scope.heading = "Product Categories"
  else
    CATEGORIES_PATH = "/service_categories"
    $scope.heading = "Service Categories"

  
  $scope.categories = []
  $scope.child_categories = {}
  $scope.attribute_id = null
  params = { parent_id: null, locale: language.get() }



  fixmeTop = $('.sticky').offset().top
  $(window).scroll ->
    currentScroll = $(window).scrollTop()
    if currentScroll >= fixmeTop
      $('.list-container').css("margin-top", "235px");
      $('.sticky').css
        position: 'fixed'
        top: '0'
    else
      $('.list-container').css("margin-top", "0px");
      $('.sticky').css position: 'static'
    return

  $scope.serviceLink = (id)->
    "/results?type=service&category="+id

  $scope.show_more = (div) ->
    $("#list-"+div).css("height", "100%");
    $("#show-more-"+div).addClass("hide");
    return
    
  $scope.show_less = (div) ->
    $("#list-"+div).css("height", "250px");
    $("#show-more-"+div).removeClass("hide");
    return
  
  $scope.scroll_to = (id) ->
    $('html, body').animate { scrollTop: $('#'+id).offset().top - 260}, 500
    

  $scope.fetch_sub_categories = (attribute_id,array) ->
    $scope.temp = {}
    $http.get(CATEGORIES_PATH, { params: params }).success((data) ->
      $scope.temp[attribute_id] = data 
    )
    $scope.temp

  $http.get(CATEGORIES_PATH, { params: params }).success((data) ->
    for attributes in data
      $scope.categories.push(attributes)
      params = { parent_id: attributes.id, locale: language.get() }
      $scope.child_categories = $scope.fetch_sub_categories(attributes.id,$scope.child_categories)
  )


]
