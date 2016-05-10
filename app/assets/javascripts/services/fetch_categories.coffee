@Sim.service 'FetchCategories', ['$http','language',
  ($http,language) ->

    initialize: (scope,path) ->
      params = { parent_id: null, locale: language.get() }
      $http.get(path, { params: params }).success((data) ->
        for attributes in data
          scope.categories.push(attributes)
          params = { parent_id: attributes.id, locale: language.get() }
          scope.child_categories = fetch_sub_categories(attributes.id,scope.child_categories)
      )

      fetch_sub_categories = (attribute_id,array) ->
        scope.temp = {}
        $http.get(path, { params: params }).success((data) ->
          scope.temp[attribute_id] = data 
        )
        scope.temp
]