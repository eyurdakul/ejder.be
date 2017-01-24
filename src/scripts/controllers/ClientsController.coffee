"use strict"
ClientsController = [
  "$scope"
  "$log"
  "$filter"
  "ContentProviderService"
  "SpinnerService"
  ($scope, $log, $filter, ContentProviderService, SpinnerService)->

    $log.debug "Creating ClientsController"

    $scope.data = undefined

    $scope.init = ->
      SpinnerService.setLoading true
      ContentProviderService.get("clients")
      .then handleData, null, handleData
      true

    handleData = (response)->
      $scope.data = response
      SpinnerService.setLoading false

    @
]
