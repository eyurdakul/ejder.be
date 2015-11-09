BackendConnectionService = [
  "$http", "$q", ($http, $q)->
    get = (model)->
      return if not model
      deferred = $q.defer()
      $http.get("/get/"+model).then (data)->
        deferred.resolve data
      deferred.promise
    get:get
]