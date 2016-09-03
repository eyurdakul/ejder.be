ContentProviderService = [
  "$log", "$location", "$q", ($log, $location, $q)->

    $log.debug "Creating ContentProviderService"

    promises = {}
    content = {}

    CONSTANTS =
      connectionPort: ":400"
      protocolSuffix: "://"
      eventConnected: "connectionEstablished"
      eventResult: "result"
      eventError: "queryError"
      eventUpdate: "update"

    onData = (data)->
      return unless promises[data.model]
      content[data.model] = data.response
      promises[data.model].notify  content[data.model]

    onUpdate = (data)->
      socket.emit "query",
        model: data.model

    get = (model)->
      return unless model
      deferred = $q.defer()
      if not content[model]
        promises[model] = deferred
        socket.emit "query",
          model: model
      else
        deferred.notify content[model]
      deferred.promise

    socket = io.connect($location.$$protocol+CONSTANTS.protocolSuffix+$location.$$host+CONSTANTS.connectionPort)
    socket.on CONSTANTS.eventConnected, (data)->
      $log.debug "Connection is established with the socket.io server on: "+data.datetime

    socket.on CONSTANTS.eventResult, onData
    socket.on CONSTANTS.eventUpdate, onUpdate

    get: get
]