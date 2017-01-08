"use strict"
SpinnerService = [
  "$log"
  ($log)->
    $log.debug "Creating SpinnerService"

    loading = true

    setLoading = (isLoading)->
      loading = isLoading

    getLoading = ->
      loading

    setLoading: setLoading
    getLoading: getLoading
]