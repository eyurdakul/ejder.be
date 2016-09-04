ErrorLogFactory = ($log, $window, SocketService)->
  (exception, cause)->
    $log.error.apply $log, arguments

    EVENT_CLIENT_SIDE_EXCEPTION = "clientSideException"

    errorMessage = exception.toString()
    StackTrace.get()
    .then (stackTrace)->
      SocketService.emit EVENT_CLIENT_SIDE_EXCEPTION,
        errorUrl: $window.location.href
        errorMessage: errorMessage
        stackTrace: stackTrace
        cause: (cause or "")