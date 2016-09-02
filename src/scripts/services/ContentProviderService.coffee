ContentProviderService = [
  "$log", "$http", "$q", ($log, $http, $q)->

    $log.debug "Creating ContentProviderService"

    get = (model)->
      return unless model
      deferred = $q.defer()
      if model
        deferred.resolve {}
      deferred.promise
    get:get
]