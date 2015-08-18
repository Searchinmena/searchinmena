@Sim.service 'SearchService', ['Search',
   (Search) ->
    perform: (search) ->
      Search.query(search.toParams())
]

