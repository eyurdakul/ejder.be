ContentProviderService = [
  "$log", "$location", "$q", "SocketService", ($log, $location, $q, SocketService)->

    $log.debug "Creating ContentProviderService"

    promises = {}
    content = {}

    CONSTANTS =
      eventQuery: "query"
      eventResult: "result"
      eventError: "queryError"
      eventUpdate: "update"

    onData = (data)->
      return unless promises[data.model]
      content[data.model] = data.response
      promises[data.model].notify  content[data.model]

    onUpdate = (data)->
      SocketService.emit CONSTANTS.eventQuery,
        model: data.model

    get = (model)->
      return unless model
      deferred = $q.defer()
      if not content[model]
        promises[model] = deferred
        SocketService.emit CONSTANTS.eventQuery,
          model: model
      else
        deferred.notify content[model]
      deferred.promise

    SocketService.registerCallback CONSTANTS.eventResult, onData
    SocketService.registerCallback CONSTANTS.eventUpdate, onUpdate

    get: get
]