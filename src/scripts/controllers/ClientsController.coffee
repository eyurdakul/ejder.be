"use strict"
ClientsController = [
  "$scope"
  "$log"
  "ContentProviderService"
  "SpinnerService"
  ($scope, $log, ContentProviderService, SpinnerService)->

    $log.debug "Creating ClientsController"

    $scope.data = undefined

    $scope.init = ->
      SpinnerService.setLoading true
      ContentProviderService.get("clients")
      .then handleData, null, handleData
      true

    handleData = (response)->
      console.log response
      $scope.data = response
      SpinnerService.setLoading false

    @
]