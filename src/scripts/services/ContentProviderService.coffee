ContentProviderService = [
  "$log", "$location", "$q", ($log, $location, $q)->

    $log.debug "Creating ContentProviderService"

    promises = {}

    CONSTANTS =
      connectionPort: ":400"
      protocolSuffix: "://"

    socket = io.connect($location.$$protocol+CONSTANTS.protocolSuffix+$location.$$host+CONSTANTS.connectionPort)
    socket.on "connectionEstablished", (data)->
      $log.debug "Connection is established with the socket.io server on: "+data.datetime

    socket.on "result", (data)->
      return unless promises[data.model]
      promises[data.model].resolve data.response

    get = (model)->
      return unless model
      deferred = $q.defer()
      promises[model] = deferred
      socket.emit "query",
        model: model
      deferred.promise

    get: get
]